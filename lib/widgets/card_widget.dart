import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CardWidget extends StatefulWidget {

  final String title, description, publishedAt, urlImage, source;
  const CardWidget({Key? key, required this.title, required this.description, required this.publishedAt, required this.urlImage, required this.source}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width, // Set width to screen width
        child: Card(
            surfaceTintColor: Colors.white,
            elevation: 4.0, // Add elevation for the box shadow
            shadowColor: Colors.grey, // Set shadow color to grey
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "2 hours ago  ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.source,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 16,
                              color: kBlue,
                              height: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                            widget.description,
                          style: TextStyle(
                              fontSize: 12,
                              color: kBlue,
                              height: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    widget.urlImage,
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  )
                ],
              ),
            )),
      ),
    );
  }
}