import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quantum/screens/login_screen.dart';
import 'package:quantum/widgets/card_widget.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String search = '';

  final String apiKey =
      '35a09884347c49d5b942eff15e09f3ba'; // Replace with your NewsAPI key
  List<dynamic> newsData = [];

  Future<void> fetchNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-08-08&sortBy=publishedAt&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        newsData = data['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: kBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhysicalModel(
              color: Colors.white,
              elevation: 10,
              child: Container(
                height: 68,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 42,
                        color: kBlue,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: kBlue,
                          ),
                          decoration: InputDecoration(
                            border: null,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Search in feeds',
                            hintStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                              color: kBlue,
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              search = value.toString();
                            });
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.logout,
                            color: kBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ListView.builder(
              itemCount: 20,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final article = newsData[index];
                final title = article['title'];
                final description = article['description'];
                final publishedAt = article['publishedAt'];
                final urlToImage = article['urlToImage'];
                final source = article['source']['name'];

                late String position = index.toString();

                if (searchController.text.isEmpty) {
                  return CardWidget(
                    title: title,
                    description: description,
                    publishedAt: publishedAt,
                    source: source,
                    urlImage: urlToImage,
                  );
                } else if (title
                        .toString()
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()) ||
                    description
                        .toString()
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()) ||
                    source
                        .toString()
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                  return CardWidget(
                    title: title,
                    description: description,
                    publishedAt: publishedAt,
                    source: source,
                    urlImage: urlToImage,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
