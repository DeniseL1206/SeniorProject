import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sql_conn/sql_conn.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<void> connect() async {
  //   debugPrint("Connecting...");
  //   try {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const AlertDialog(
  //           title: Text("LOADING"),
  //           content: CircularProgressIndicator(),
  //         );
  //       },
  //     );
  //     await SqlConn.connect(
  //         ip: "campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com",
  //         port: "3306",
  //         databaseName: "Koi",
  //         username: "admin",
  //         password: "BangTanS13!");
  //     debugPrint("Connected!");
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     Navigator.pop(context);
  //   }
  // }

  // Future<void> read(String query) async {
  //   var res = await SqlConn.readData(query);
  //   debugPrint(res.toString());
  // }

  // Future<void> write(String query) async {
  //   var res = await SqlConn.writeData(query);
  //   debugPrint(res.toString());
  // }
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Home', key: Key('home-text')),
        backgroundColor: Color(0xFFFF9E80),
        elevation: 0,
      ),
      body:
      // Row( 
      //        mainAxisAlignment: MainAxisAlignment.end,
      //        children: <Widget>[
      //       IconButton(
      //           icon: Icon(Icons.sort),
      //          onPressed: () {/* ... */},
      //         ),]),);
       Container(
        color: Colors.deepOrange.shade50,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return Task();
          },
        ),
       //]),
    ));
  }
}

class Task extends StatefulWidget {
  //String taskTitle;
  //bool checked;

  //Task(this.taskTitle, this.checked);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        //borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Padding(padding: EdgeInsets.all(12.0), child: CircleAvatar(backgroundImage: AssetImage('redwhitekoifishavatar.jpg'),)), 
            Padding(padding: EdgeInsets.fromLTRB(1, 11, 3, 3), child: Text(' r/ESSBL \n firstuser@utrgv.edu', style: TextStyle(fontSize: 15))),
            Spacer(),
            Padding(padding: EdgeInsets.all(12.0), child: Text('2022-10-09'),), 
          ]),
          ListTile(title: Text('Excited about the new app!'),
          subtitle: Text('I am very happy that an application like this exists for the university. Definitely excited to implement this in my campus life.'),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.sentiment_dissatisfied_outlined),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.comment_outlined),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
