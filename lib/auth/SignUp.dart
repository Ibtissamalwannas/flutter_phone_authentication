import 'package:flutter/material.dart';
import 'package:simple_screens/SplashScreen.dart';
import 'package:simple_screens/auth/auth_page.dart';
import 'package:simple_screens/auth/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_screens/auth/phone_verification.dart';
import 'package:simple_screens/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('wrong'),
          );
        } else if (snapshot.hasData) {
          return Home();
        } else {
          return PhoneVerification();
        }
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    ));
  }
}
