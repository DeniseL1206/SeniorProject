import 'package:flutter/material.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool selectedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
            leading: IconButton(
                key: Key("back-button"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF))),
            title: Padding(
            padding: EdgeInsets.only(left: 158), child: Text('Pond')),
            backgroundColor: Color(0xFFFF9E80),
            elevation: 0,
          ),
          body: 
          SafeArea(
        child: Container(
          color: Colors.deepOrange.shade50,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: InteractiveViewer(
                    child: Image.asset('utrgvcampusmap.png'),
                    //transformationController: controller,
                    boundaryMargin: EdgeInsets.all(5.0),
                    onInteractionEnd: (ScaleEndDetails endDetails) {
                     // print(endDetails);
                     // print(endDetails.velocity);
                      //controller.value = Matrix4.identity();
                      setState(() {
                        //velocity = endDetails.velocity.toString();

                      });
                      },
                  ),
                ),
              ),
              //Text(velocity,style: TextStyle(
               //fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    //       Container(
    //     alignment: Alignment.center,
    //     padding: const EdgeInsets.all(32),
    //     decoration: const BoxDecoration(
    //       //gradient: LinearGradient(begin: Alignment.center, end: Alignment.bottomCenter, colors: Colors.orange),
    //       image: DecorationImage(
    //         image: AssetImage('utrgvcampusmap.png'),
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    // ),
    );
  }
}