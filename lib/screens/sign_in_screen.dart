// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seniorproject/main.dart';
import 'dart:async';
import 'home_screen.dart';
import 'create_account_screen.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool submit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      setState(() {
        submit = emailController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Login Page"),
          key: Key("title"),
          backgroundColor: Color(0xFFFF9E80),
          elevation: 0,
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
                  cursorColor: Color(0xFFFF9E80),
                  key: Key("email-input"),
                  controller: emailController,
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
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xFFFF9E80))),
                    errorText:
                        emailHandle ? null : "Please enter a valid utrgv email",
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xFFFF9E80)),
                    hintText: 'Enter valid email id ending in @utrgv.edu',
                    hoverColor: Color(0xFFFF9E80),
                    focusColor: Color(0xFFFF9E80),
                    fillColor: Color(0xFFFF9E80),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  cursorColor: Color(0xFFFF9E80),
                  key: Key("password-input"),
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xFFFF9E80))),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xFFFF9E80)),
                    hintText: 'Enter secure password',
                    hoverColor: Color(0xFFFF9E80),
                    focusColor: Color(0xFFFF9E80),
                    fillColor: Color(0xFFFF9E80),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                key: Key("forgot-password"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen()));
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Color(0xFFFF9E80), fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  //color:  Color(0xFFFF9E80), borderRadius: BorderRadius.circular(20)),
                  color: Color(0xFFFF9E80),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFFFF9E80)),
                  onPressed: submit && emailHandle
                      ? () {
                          signIn();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      BottomNavBar(emailController.text)));
                        }
                      : null,
                  key: Key("login-button"),
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New User?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateAccountScreen()));
                      },
                      child: Text('Create Account',
                          style: TextStyle(color: Color(0xFFFF9E80)),
                          key: Key('new-user'))),
                ],
              )
              // Text('New User?'),
              // TextButton(onPressed: () {}, child: Text('Create Account', key: Key('new-user'))),
            ],
          ),
        ));
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  void setValidator(valid) {
    setState(() {
      emailHandle = valid;
    });
  }
}
