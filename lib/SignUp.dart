import 'package:flutter/material.dart';
import 'package:simple_screens/SplashScreen.dart';
import 'package:simple_screens/auth_page.dart';
import 'package:simple_screens/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_screens/phone.dart';
import 'package:simple_screens/text.dart';

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
          return text();
        } else {
          return MyPhone();
        }
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    ));
  }
}
