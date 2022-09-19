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
        title: Text("Rating System Screen"),
      ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 130,
            ),
            Text('This is the rating System Screen')
          ],
        ))
        
        );
  }
}