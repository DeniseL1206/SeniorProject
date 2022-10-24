import 'package:flutter/material.dart';
import 'package:seniorproject/screens/map_screen.dart';
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
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(32),
          decoration: const BoxDecoration(
            //gradient: LinearGradient(begin: Alignment.center, end: Alignment.bottomCenter, colors: Colors.orange),
            image: DecorationImage(
              image: AssetImage('KoiInWater.png'), 
              fit: BoxFit.cover,
              ),
            ),
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                    style: 
                      ElevatedButton.styleFrom(primary: Color(0xFFFF9E80),
                      minimumSize: Size(200, 60)),
                    onPressed: () { Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MapScreen()));},
                    child: const Text('Explore the Pond', key: Key('rating-system-text')),
                  ),
              ),
          ),
        );
  }
}