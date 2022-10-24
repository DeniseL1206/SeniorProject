import 'package:flutter/material.dart';
import 'dart:async';
import 'sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, navigateToDeviceScreen);
  }

  navigateToDeviceScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF9E80),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "Koi",
            //   style: TextStyle(
            //       fontStyle: FontStyle.normal,
            //       fontSize: 48,
            //       fontWeight: FontWeight.normal,
            //       color: Color(0xFFFFFFFF),
            //       fontFamily: "norwester"),
            // ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 90, 0),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: new Image(image: new AssetImage('koi-fish.gif')),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 250),
              child: Text(
                "Creating a bond within our pond.",
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "kollektif"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
