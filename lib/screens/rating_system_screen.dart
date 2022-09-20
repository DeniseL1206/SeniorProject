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
            title: IconButton(
                key: Key("back-button"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF))),
            backgroundColor: Colors.blue,
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