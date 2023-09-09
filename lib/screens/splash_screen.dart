import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quantum/screens/home_page.dart';
import 'package:quantum/screens/login_screen.dart';
import 'package:quantum/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var auth = FirebaseAuth.instance;
  bool _isLoading = true;

  checkIsLoggedIn() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {

          setState(() {
            Timer(Duration(seconds: 3), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
            });
          });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body:   Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Quantum IT\nInnovation", style: TextStyle(
              fontSize: 26,
              color: kBlue,
              fontWeight: FontWeight.bold
            ),
              textAlign: TextAlign.center,
            ),
          ),

          _isLoading? Center(child: CircularProgressIndicator(strokeWidth: 2, color: kBlue,)):SizedBox()
        ],
      ),
    );
  }
}
