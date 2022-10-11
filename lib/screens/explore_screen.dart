import 'package:flutter/material.dart';
import 'dart:async';

class ExplorerScreen extends StatefulWidget {
  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Explore'),
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
        Text('This is the Explorer Screen',  key: Key("explorer-text")),
          ],)
      )
        );
  }
}