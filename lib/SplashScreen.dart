import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'SignUp.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        nextScreen: SignUp(),
        splash: Lottie.asset('assets/healthy-or-junk-food.json', animate: true),
        duration: 3000,
        splashIconSize: 400);
  }
}
