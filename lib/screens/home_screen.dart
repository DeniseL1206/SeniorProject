//import 'dart:html';
//import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:seniorproject/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:seniorproject/utils/database_connection.dart';
import 'package:seniorproject/screens/expanded_post_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

const List<String> reportTypes = <String>[
  'Hate speech or symbols',
  'Violence or threat of violence',
  'Harassment or bullying',
  'Self injury'
];

String reportValue = '';

const List<String> comms = <String>[
  'Social Work and Occupational Therapy',
  'International Trade & Technology',
  'Orville Cox Tennis Center',
  'Track & Soccer Field',
  'Performing Arts Complex A',
  'Southwick Hall',
  'Performing Arts Complex C',
  'Performing Arts Complex B',
  'Executive Tower',
  'Student Services Building',
  'Visitors Center',
  'Mathematics & Science Academy',
  'Marialice Shary Shivers',
  'Student Academic Center',
  'University Center',
  'Chapel',
  'Student Union',
  'Dining & Ballroom Complex',
  'Health & Physical Education II',
  'Engineering Portable',
  'Engineering',
  'Academic Services',
  'Physical Science',
  'Intramural Fields',
  'Troxel Hall',
  'Heritage Hall',
  'Emilia Schunior Ramirez Hall',
  'Sugar Road Annex',
  'Health & Physical Education Complex Fieldhouse',
  'H.E.B. Planetarium',
  'Science',
  'The Learning Center',
  'University Library',
  'Liberal Arts Building South',
  'Child Development Center',
  'Agroecology Research Community Garden',
  'Greenhouse',
  'Portable Buildings 9, 10, 11, 12, 13',
  'Education Complex',
  'Mathematics & General Classrooms',
  'Computer Center',
  'Robert C. Vackar College of Business and Entrepreneurship',
  'Central Utility Plant',
  'Health Affairs Building East',
  'Behavioral Neurosciences',
  'Health Affairs Building West',
  'Health Affairs Building West Classroom A',
  'Health Affairs Building West Auditorium',
  'Liberal Arts Building North',
  'Unity Hall',
  'Rio Grande Center for Manufacturing',
  'Police and Parking & Transportation Offices',
  'Academic Support Facility',
  'The Village A',
  'The Village B',
  'The Village C',
  'The Village D',
  'The Village E',
  'The Village F',
  'Environmental Health & Safety',
  'Thermal Storage Tank',
  'Lamar E',
  'Research Education-(School of Medicine)',
  'Medical Education-(School of Medicine)',
  'Student Health Center',
  'University Recreation',
  'ROTC Storage',
  'ROTC',
  'Baseball Stadium',
  'Soccer and Track & Field Complex'
];

String postComm = '';

//Dropdown for New Post Comms
class DropdownButtonComms extends StatefulWidget {
  const DropdownButtonComms({key});

  @override
  State<DropdownButtonComms> createState() => _DropdownButtonComms();
}

class _DropdownButtonComms extends State<DropdownButtonComms> {
  String dropdownValue = comms.first;
  String selectedCommunity = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          postComm = dropdownValue;
        });
      },
      items: comms.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//DropDown for Reporting
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = reportTypes.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      // hint: Text("Choose a reason for reporting:",
      //   key: Key('report-prompt-text')),
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          reportValue = dropdownValue;
        });
      },
      items: reportTypes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

//Home Page
class HomeScreen extends StatefulWidget {
  String userEmail = '';
  HomeScreen(this.userEmail);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var postTitleTextController = TextEditingController();
  var postDescriptionTextController = TextEditingController();
  // var postTitle = null;
  // var postDescription = null;
  final ScrollController _scrollController = ScrollController();

  void _showDialogNewPost() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
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
                      Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.cancel_outlined),
                              onPressed: () => Navigator.pop(context),
                              color: Color(0xFFFF9E80),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DropdownButtonComms(),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: postTitleTextController,
                      decoration: InputDecoration(
                        hintText: "Post Title",
                        border: InputBorder.none,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: postDescriptionTextController,
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
                            onPressed: () {
                              DatabaseConnection.InsertPost(
                                  widget.userEmail,
                                  postComm,
                                  postTitleTextController.text,
                                  postDescriptionTextController.text);
                              Navigator.pop(context);
                            },
                            child: const Text("Post"))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    // resizeToAvoidBottomPadding:
    // false;
    // resizeToAvoidBottomInset:
    // false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          child: PostGeneration(widget.userEmail)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialogNewPost();
          //Refresh Page
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

//Generation of Posts Test Functions
class PostGeneration extends StatefulWidget {
  String userEmail = '';
  PostGeneration(this.userEmail);

  @override
  _PostGeneration createState() => _PostGeneration();
}

class _PostGeneration extends State<PostGeneration> {
  late Future<Results> results;

  @override
  void initState() {
    super.initState();
    results = DatabaseConnection.PostsforUser(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Posts(results);
  }
}

class Posts extends StatefulWidget {
  Future<Results> posts;
  Posts(this.posts);

  @override
  _Posts createState() => _Posts();
}

class _Posts extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.posts,
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

              return ListView(
                children: [
                  for (var element in truePosts)
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'redwhitekoifishavatar.jpg'),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(1, 11, 3, 3),
                                    child: 
                                        AutoSizeText(
                                      ' r/${element[2]} \n ${element[1]}',
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 2,
                                    )),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: 
                                        AutoSizeText(
                                      '${DateFormat('yyyy-MM-dd').format(element[3])
                                      }',
                                      style: TextStyle(fontSize: 2),
                                      maxLines: 1,
                                    )),
                              ]),
                          ListTile(
                              title: 
                                  Text('${element[4]}'),
                              subtitle: 
                                  Text('${element[5]}')),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.blue),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ExpandedPostScreen("home")));
                              });
                            },
                            child: const Text('View More...'),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
