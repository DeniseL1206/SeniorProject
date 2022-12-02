import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String _email = '';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Reset Password'),
        backgroundColor: Color(0xFFFF9E80),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xFFFF9E80))),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xFFFF9E80)),
                    hintText: 'Email',
                    hoverColor: Color(0xFFFF9E80),
                    focusColor: Color(0xFFFF9E80),
                    fillColor: Color(0xFFFF9E80),
                  ),
                  // decoration: const InputDecoration(
                  //   hintText: 'Password',
                  // ),

                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text('Send Request'),
                  onPressed: () {
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(primary: Color(0xFFFF9E80)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
