import 'package:seniorproject/screens/home_screen.dart';
import 'package:auth_service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seniorproject/utils/database_connection.dart';

class CreateAccountScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Create Account'),
        backgroundColor: Color(0xFFFF9E80),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CreateAccountEmail(emailController: _emailController),
            const SizedBox(height: 30.0),
            _CreateAccountPassword(passwordController: _passwordController),
            const SizedBox(height: 30.0),
            _SubmitButton(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateAccountEmail extends StatelessWidget {
  _CreateAccountEmail({
    Key? key,
    required this.emailController,
  }) : super(key: key);
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Color(0xFFFF9E80))),
          border: OutlineInputBorder(),
          labelText: 'Email',
          labelStyle: TextStyle(color: Color(0xFFFF9E80)),
          hintText: 'Email',
          hoverColor: Color(0xFFFF9E80),
          focusColor: Color(0xFFFF9E80),
          fillColor: Color(0xFFFF9E80),
        ),
        //decoration: const InputDecoration(hintText: 'Enter valid email id ending in @utrgv.edu'),
      ),
    );
  }
}

class _CreateAccountPassword extends StatelessWidget {
  _CreateAccountPassword({
    Key? key,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Color(0xFFFF9E80))),
          border: OutlineInputBorder(),
          labelText: 'Password',
          labelStyle: TextStyle(color: Color(0xFFFF9E80)),
          hintText: 'Password',
          hoverColor: Color(0xFFFF9E80),
          focusColor: Color(0xFFFF9E80),
          fillColor: Color(0xFFFF9E80),
        ),
        // decoration: const InputDecoration(
        //   hintText: 'Password',
        // ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  _SubmitButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final String email, password;
  final AuthService _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Color(0xFFFF9E80)),
      onPressed: () async {
        try {
          await _authService.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          //DatabaseConnection.InsertUser(email);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
      child: Text('Create Account',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    );
  }
}
