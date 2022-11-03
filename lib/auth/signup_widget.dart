import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../utils.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickeSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickeSignIn,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool _isVisible = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/pass.png',
                  width: width * 0.5,
                  height: height * 0.25,
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                TextFormField(
                  controller: emailController,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: _isVisible ? false : true,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      splashRadius: 1,
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? Icon(Icons.visibility, color: Colors.black87)
                          : Icon(Icons.visibility_off, color: Colors.grey),
                    ),
                    hintText: 'Password',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter min 6 character'
                      : null,
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Color.fromARGB(255, 252, 171, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: SignUp,
                  icon: Icon(
                    Icons.lock_open,
                    size: 32,
                  ),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Color.fromARGB(255, 130, 130, 128)),
                    text: 'Aready have an account? ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickeSignIn,
                        text: 'Sign In',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 252, 171, 49)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        builder: (context) => Center(
              child: Lottie.asset('assets/loading.json', animate: true),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

@override
Widget build(BuildContext context) {
  return Container();
}
