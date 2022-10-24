//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:seniorproject/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var postTitleTextController = TextEditingController();
  var postDescriptionTextController = TextEditingController();
  var postTitle = null;
  var postDescription = null;

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "New Post",
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Padding(padding: EdgeInsets.only(left: 65.0), child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.cancel_outlined),
                            onPressed: () => Navigator.pop(context),
                            color: Color(0xFFFF9E80),
                            ),                           
                        ],
                      ),)
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Post Title",
                        border: InputBorder.none,
                      ),
                      maxLines: 2,
                    ),
                  ),
                 Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Post Description",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF9E80),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: TextButton(
                       style: TextButton.styleFrom(primary: Colors.white),
                       onPressed: () => Navigator.pop(context),
                       child: const Text("Post"))
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Home', key: Key('home-text')),
        backgroundColor: Color(0xFFFF9E80),
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(CupertinoIcons.sort_up_circle),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Oldest to Newest")
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    Icon(CupertinoIcons.sort_down_circle),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Newest to Oldest"),
                  ],
                ),
              ),
            ],
            offset: Offset(0, 100),
            color: Colors.grey,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                //_showDialog();
                // if value 2 show dialog
              } else if (value == 2) {
                //_showDialog();
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFF9E80),
              ),
              accountName: Text(
                "Randomly Generated UserName",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "firstuser@utrgv.edu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('redwhitekoifishavatar.jpg'),
                  radius: 8),
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                //Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignInScreen()));
              },
            ),
          ],
        ),
      ),

      body: Container(
        color: Colors.deepOrange.shade50,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return Task();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog();
          //// Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => super.widget));
        },
        backgroundColor: Color(0xFFFF9E80),
      ),
    );
  }
}

class Task extends StatefulWidget {
  
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
            Padding(
                padding: EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('redwhitekoifishavatar.jpg'),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(1, 11, 3, 3),
                child: Text(' r/ESSBL \n firstuser@utrgv.edu',
                    style: TextStyle(fontSize: 15))),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('2022-10-09'),
            ),
          ]),
          ListTile(
            title: Text('Excited about the new app!'),
            subtitle: Text(
                'I am very happy that an application like this exists for the university. Definitely excited to implement this in my campus life.'),
          ),
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
