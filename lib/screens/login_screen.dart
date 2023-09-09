import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantum/screens/sign_up_screen.dart';
import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null; // User canceled the sign-in process
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    return authResult.user;
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text.toString(),
        password: _passwordController.text.toString());
    if (res == "Success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        "LOGIN",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
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
                          "SIGN UP",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )),
                      ),
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
                          "SignIn into your\naccount",
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
                        "Email",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'johndoe@gmail.com',
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.red,
                          ), // Add the email icon here
                        ),
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
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'password',
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.red,
                          ), // Add the email icon here
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                          child: Text(
                        "Login With",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              User? user = await signInWithGoogle();
                              if (user != null) {
                                // User signed in successfully
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => HomePage()));
                              } else {
                                // User canceled the sign-in process
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("failed"),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: Center(
                                  child: Image.asset("assets/images/google.png")),
                            ),
                          ),
                          SizedBox(
                            width: 48,
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(2),
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: Center(
                                child:
                                    Image.asset("assets/images/facebook.png")),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Register Now',
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
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  loginUser();
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
                      child: _isLoading
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            )
                          : Text(
                              "LOGIN",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
