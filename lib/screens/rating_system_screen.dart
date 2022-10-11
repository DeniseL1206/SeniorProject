import 'package:flutter/material.dart';
import 'dart:async';

class RatingSystemScreen extends StatefulWidget {
  @override
  _RatingSystemScreenState createState() => _RatingSystemScreenState();
}

class _RatingSystemScreenState extends State<RatingSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Rating System'),
          backgroundColor: Color(0xFFFF9E80),
          elevation: 0,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 130,
            ),
            Text('This is the Rating System Screen',  key: Key("rating-system-text"))
          ],
        ))
        
        );
  }
}