import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
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
                  controller: emailController,
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
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text('Reset Password'),
                  onPressed: () {
                    resetPassword();
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

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());

    const snackBar = SnackBar(content: Text('Password Reset Email Sent'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
