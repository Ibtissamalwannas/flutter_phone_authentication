import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:firebase_auth/firebase_auth.dart';

class text extends StatefulWidget {
  const text({super.key});

  @override
  State<text> createState() => _textState();
}

class _textState extends State<text> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Color.fromARGB(255, 252, 171, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => {
                    FirebaseAuth.instance.signOut(),
                  },
                  icon: Icon(
                    Icons.map_sharp,
                    size: 32,
                  ),
                  label: Text(
                    'Go to map',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Color.fromARGB(255, 252, 171, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => {
                    FirebaseAuth.instance.signOut(),
                  },
                  icon: Icon(
                    Icons.camera,
                    size: 32,
                  ),
                  label: Text(
                    'Open Camera',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Color.fromARGB(255, 252, 171, 49),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => {
                    FirebaseAuth.instance.signOut(),
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 32,
                  ),
                  label: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
