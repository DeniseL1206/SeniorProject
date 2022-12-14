import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:seniorproject/screens/sign_in_screen.dart';
import 'package:seniorproject/screens/home_screen.dart';
import 'package:seniorproject/screens/explore_screen.dart';
import 'package:seniorproject/screens/notifications_screen.dart';
import 'package:seniorproject/screens/rating_system_screen.dart';
import 'package:seniorproject/screens/resources_screen.dart';
import 'package:seniorproject/screens/splash_screen.dart';
import 'package:seniorproject/utils/database_connection.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
      home: SplashScreen(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  String userEmail = '';
  BottomNavBar(this.userEmail);

  @override
  static const String _Title = 'Flutter Sample code ';

  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String returnEmail() {
    String email = '';
    email = widget.userEmail;
    return email;
  }

  late Future<Results> username;
  late Widget user_name = Text("hi");

  @override
  void initState() {
    super.initState();
    username = DatabaseConnection.GetUsername(widget.userEmail);
    user_name = buildUsername();
    //user_name = username.toString();
    //user_name = username[0];
  }

  Widget buildUsername() => FutureBuilder(
      future: username,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            final truePosts = snapshot.data as Results;
            for (var element in truePosts) return Text('${element[0]}');
          }
        }
        return Text("");
      });

  // void setUsername() {
  //   user_name = buildUsername();
  // }

  int _currentIndex = 0;
  late String email = returnEmail();

  late final List<Widget> _children = [
    HomeScreen(email, user_name),
    ExplorerScreen(email, user_name),
    RatingSystemScreen(),
    NotificationsScreen(email, user_name),
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
          key: Key('navigation-bar'),
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home, color: Color(0xFFFF9E80)),
              label: "Home",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search, color: Color(0xFFFF9E80)),
              label: "Explorer",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.star, color: Color(0xFFFF9E80)),
              label: "Rating System",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_active,
                  color: Color(0xFFFF9E80)),
              label: "Notifications",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.link, color: Color(0xFFFF9E80)),
              label: "Resources",
              backgroundColor: Colors.white,
            )
          ],
          selectedItemColor: Colors.white,
        ));
  }
}

// Future dataCollection() async {
//   final conn = await MySqlConnection.connect(ConnectionSettings(
//       host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
//       port: 3306,
//       user: 'admin',
//       db: 'campussafetyapp',
//       password: 'BangTanS13!'));

//   var results = await conn.query(
//       'select user_guid, post_guid from posts where post_date = 2022-10-09');

//   for (var row in results) {
//     print('User Guid: ${row[0]}, Post Guid: ${row[1]}');
//   }

//   await conn.close();
// }
