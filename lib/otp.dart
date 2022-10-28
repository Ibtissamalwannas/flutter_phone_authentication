import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:simple_screens/SignUp.dart';
import 'package:simple_screens/main.dart';
import 'package:simple_screens/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_screens/text.dart';
import 'package:lottie/lottie.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(30, 60, 87, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 300,
                height: 170,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Enter OTP",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 252, 171, 49)),
              ),
              SizedBox(
                height: 20,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 252, 171, 49),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: Lottie.asset('assets/done.json',
                                    animate: true),
                              ));
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: MyPhone.verify, smsCode: code);
                        await auth.signInWithCredential(credential);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => text()),
                        );
                      } catch (e) {
                        print("wrong otp");
                      }
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                    },
                    child: Text("Verify Phone Number")),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "To Edit Phone Number?",
                    style: TextStyle(color: Color.fromARGB(255, 130, 130, 128)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyPhone()),
                      );
                    },
                    child: Text(
                      "Click here",
                      style:
                          TextStyle(color: Color.fromARGB(255, 252, 171, 49)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
