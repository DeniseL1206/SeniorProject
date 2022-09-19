import 'package:flutter/material.dart';
import 'package:seniorproject/screens/sign_in_screen.dart';
import 'package:seniorproject/screens/home_screen.dart';
import 'package:seniorproject/screens/explore_screen.dart';
import 'package:seniorproject/screens/notifications_screen.dart';
import 'package:seniorproject/screens/rating_system_screen.dart';
import 'package:seniorproject/screens/resources_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
    );
  }
}

//Class to implement Navigation Bar That will direct to the different pages

class BottomNavBar extends StatefulWidget {
  @override
  static const String _Title = 'Flutter Sample code ';

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    ExplorerScreen(),
    RatingSystemScreen(),
    NotificationsScreen(),
    ResourcesScreen()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              label: "Explorer",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.star),
              label: "Rating System",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_active),
              label: "Notifications",
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.link),
              label: "Resources",
              backgroundColor: Colors.blue,
            )
          ],
          selectedItemColor: Colors.amber[500],
        ));
  }
}
