import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quantum/screens/home_page.dart';
import 'package:quantum/screens/login_screen.dart';
import '../utils/colors.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool isLoading = false;

  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _phoneNoEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    bool _isChecked = false;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: false,
        title: const Row(
          children: [
            Text(
              "Social",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              " X",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity * 0.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32))),
                        child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            )),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 60,
                      width: double.infinity * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32))),
                      child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 226,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Create an\naccount",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _nameEditingController,
                        decoration: InputDecoration(
                          hintText: 'john doe',
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.red,
                          ), // Add the email icon here
                        ),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _emailEditingController,
                        decoration: InputDecoration(
                          hintText: 'johndoe@gmail.com',
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.red,
                          ), // Add the email icon here
                        ),
                        onChanged: (value) {
                          email = value.trim();
                        },
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Contact No",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/india.png", width: 40, height: 32, fit: BoxFit.fitHeight,),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "IN +91",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.grey,size: 24,),
                          SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            child: TextField(
                              controller: _phoneNoEditingController,
                              decoration: InputDecoration(
                                hintText: '9876543210',
                                suffixIcon: Icon(
                                  Icons.call,
                                  color: Colors.red,
                                ), // Add the email icon here
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),

                      ),
                      TextField(
                        controller: _passwordEditingController,
                        decoration: InputDecoration(
                          hintText: 'password (min 6 char)',
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.red,
                          ), // Add the email icon here
                        ),
                        onChanged: (value) {
                          password = value.trim();
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _isChecked,
                            onChanged: (newValue) {
                              setState(() {
                                _isChecked = newValue!;
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: "I agree with  ",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'terms & conditions',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: Colors.red,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child:
                            RichText(
                              text: TextSpan(
                                text: "Already have an account ? ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign In!',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                    // Add an onTap function here to handle registration
                                    // onTap: () {
                                    //   // Navigate to registration page or perform registration action
                                    // },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                  if (_nameEditingController.text.isEmpty ||
                      _emailEditingController.text.isEmpty ||
                      _phoneNoEditingController.text.isEmpty ||
                  _passwordEditingController.text.length <6) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                        Text("Please enter all the fields"),
                      ),
                    );
                  }
                  else {
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                        email: email!,
                        password: password!,
                      );

                      if(newUser != null){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }

                      setState(() {
                        isLoading = false;
                      });

                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${e.message}"),

                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32))),
                child: Center(
                    child: isLoading? CircularProgressIndicator(strokeWidth: 2, color: Colors.white,):Text(
                      "REGISTER",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
