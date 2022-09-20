// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:seniorproject/main.dart';
import 'dart:async';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final myController = TextEditingController();
  bool submit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(() {
      setState(() {
        submit = myController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  //TextEditingController textController = TextEditingController();
  String emailValidator = "@utrgv.edu";
  bool emailHandle = true;
  bool button = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
        key: Key("title"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              //child: Center(
              //child: Container(
              //  width: 200,
              //height: 150,
              /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
              // child: Image.asset('asset/images/flutter-logo.png')),
              // ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                key: Key("email-input"),
                controller: myController,
                onChanged: (inputValue) {
                  if (inputValue.isEmpty) {
                    button = true;
                    //setValidator(true);
                  } else {
                    setValidator(false);
                    button = false;
                  }
                  if (inputValue.contains(emailValidator)) {
                    setValidator(true);
                  }
                },
                decoration: InputDecoration(
                    errorText:
                        emailHandle ? null : "Please enter a valid utrgv email",
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id ending in @utrgv.edu'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                key: Key("password-input"),
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            TextButton(
              key: Key("forgot-password"),
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: submit && emailHandle
                    ? () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => BottomNavBar()));
                      }
                    : null,
                    key: Key("login-button"),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User? Create Account',
            key: Key('new-user')),
          ],
        ),
      ),
    );
  }

  void setValidator(valid) {
    setState(() {
      emailHandle = valid;
    });
  }
}
