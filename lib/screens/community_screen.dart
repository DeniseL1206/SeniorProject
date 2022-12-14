import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:seniorproject/utils/database_connection.dart';
import 'package:seniorproject/screens/expanded_post_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../services/local_notification_service.dart';

const List<String> list = <String>[
  'Hate speech or symbols',
  'Violence or threat of violence',
  'Harassment or bullying',
  'Self injury'
];

String reportValue = '';

//DropDown for Reporting
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

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
          //value = value!;
          //Navigator.push(
          //context, MaterialPageRoute(builder: (_) => CommunityScreen()));
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class CommunityScreen extends StatefulWidget {
  String selectedCommunity;
  String userEmail = '';
  String userName = "";

  CommunityScreen(this.selectedCommunity, this.userEmail, this.userName);
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  var postTitleTextController = TextEditingController();
  var postDescriptionTextController = TextEditingController();
  var postTitle = null;
  var postDescription = null;
  final ScrollController _scrollController = ScrollController();

  late final LocalNotificationService service;

  bool oldToNew = false;
  bool newToOld = false;

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
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
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
                            onPressed: () async {
                              await DatabaseConnection.InsertPost(
                                  //widget.userName,
                                  widget.userEmail,
                                  widget.selectedCommunity,
                                  postTitleTextController.text,
                                  postDescriptionTextController.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             super.widget));
                              await service.showNotification(
                                  id: 0,
                                  title: 'You have a drop!',
                                  body: 'Thank you for creating a new post.');
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

  void _showDialogReport() {
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
                      "Report",
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
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 20, 30, 0),
                  child: Text("Choose a reason for reporting: "),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.transparent,
                  height: 4.0,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: DropdownButtonExample()),

                // Padding(
                //   padding: EdgeInsets.only(left: 30.0, right: 30.0),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       hintText: "Post Description",
                //       border: InputBorder.none,
                //     ),
                //     maxLines: 8,
                //   ),
                // ),

                SizedBox(
                  height: 35.0,
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
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Reporting Post'),
                          content: Text(
                              'Are you sure you want to report this post for ${reportValue}?'),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(primary: Colors.red),
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(primary: Colors.blue),
                              //onPressed: () => Navigator.pop(context, 'OK'),
                              onPressed: () {
                                //DatabaseConnection.ReportPost(post_guid);
                                int count = 2;
                                Navigator.of(context)
                                    .popUntil((_) => count-- == 0);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                      child: const Text('Report',
                          style: TextStyle(color: Colors.white)),
                    ),
                    // child: TextButton(
                    //     style: TextButton.styleFrom(primary: Colors.white),
                    //     onPressed: () => Navigator.pop(context),
                    //     child: const Text("Report"))),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  double _rating = 0.0;
  Widget buildRating() => RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        itemSize: 45,
        itemPadding: EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
        updateOnDrag: true,
        onRatingUpdate: (rating) => setState(() {
          this._rating = rating;
        }),
      );

  // Rating System
  void _showDialogRatingSystem() {
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
              width: 320.0,
              height: 295.0,
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
                        "Rate Safety of Ripple",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 65.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.cancel_outlined),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.amber,
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
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 30, left: 30),
                      child: buildRating()),
                  // SizedBox(height: 20.0),
                  // Text(
                  //   'Rating: ${this._rating}',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(
                    height: 57.0,
                  ),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(primary: Colors.white),
                            onPressed: () async {
                              // DatabaseConnection.RateCommunity();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                              await service.showNotification(
                                  id: 0,
                                  title: 'You have a drop!',
                                  body:
                                      'Thank you for rating the ${widget.selectedCommunity} Ripple.');
                            },
                            child: const Text("Rate"))),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool selectedValue = false;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.shade50,
      appBar: AppBar(
        leading: IconButton(
            key: Key("back-button"),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFF9E80))),
        // title: Text('${widget.selectedCommunity}'),
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert, color: Color(0xFFFF9E80)),
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(CupertinoIcons.star),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Most Popular")
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 2,
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
              PopupMenuItem(
                value: 3,
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
                oldToNew = true;
                //Posts(DatabaseConnection.GetPostOldtoNew(widget.userEmail));
                //_showDialog();
              } else if (value == 3) {
                newToOld = true;
                //Posts(DatabaseConnection.GetPostNewtoOld(widget.userEmail));
                //_showDialog();
              }
            },
          ),
        ],
      ),
      body: //SingleChildScrollView(
          //controller: _scrollController,
          //child:
          Column(
        children: [
          Container(
            height: 235,
            color: Colors.deepOrange.shade50,
            child: Card(
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
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(15, 11, 3, 3),
                            child: Text(
                                "The ${widget.selectedCommunity} Ripple",
                                style: TextStyle(fontSize: 17))),
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFF9E80),
                                minimumSize: Size(40, 20)),
                            onPressed: () async {
                              await service.showNotification(
                                  id: 0,
                                  title: 'You have a drop!',
                                  body:
                                      'Thank you for following the ${widget.selectedCommunity} Ripple.');
                              //DatabaseConnection.JoinCommunity(user_guid, community_guid);
                            },
                            child: const Text('Follow'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFF9E80),
                                minimumSize: Size(40, 20)),
                            onPressed: () {
                              _showDialogRatingSystem();
                            },
                            // onPressed: () async {
                            //   await service.showNotification(
                            //       id: 0,
                            //       title: 'You have a drop!',
                            //       body:
                            //           'Thank you for rating the ${widget.selectedCommunity} Ripple.');
                            //   //DatabaseConnection.JoinCommunity(user_guid, community_guid);
                            // },
                            child: const Text('Rate Safety'),
                          ),
                        ),
                      ]),
                  ListTile(
                    title: Text(
                        "Welcome to the ${widget.selectedCommunity} Ripple!"),
                    subtitle: Text(
                        "Thank you for visiting this part of the pond. Feel free to interact with other koi and share a story if you feel comfortable in doing so. If otherwise, you are still welcome! Hopefully you'll feel comfortable to do so in the future. Create bonds throughout the pond!"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 4,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent)),
                height: 100,
                child: showWidget()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialogNewPost();
        },
        backgroundColor: Color(0xFFFF9E80),
      ),
    );
  }

  showWidget() {
    if (oldToNew == true && newToOld == false) {
      oldToNew = false;
      return Posts(
          DatabaseConnection.GetPostOldtoNew(widget.selectedCommunity));
    } else if (newToOld == true && oldToNew == false) {
      newToOld = false;
      return Posts(
          DatabaseConnection.GetPostNewtoOld(widget.selectedCommunity));
    } else if (oldToNew == false && newToOld == false) {
      return PostGeneration(widget.selectedCommunity);
    }
  }
}

//Generation of Posts Test Functions
class PostGeneration extends StatefulWidget {
  String community = '';
  PostGeneration(this.community);

  @override
  _PostGeneration createState() => _PostGeneration();
}

class _PostGeneration extends State<PostGeneration> {
  late Future<Results> results;

  @override
  void initState() {
    super.initState();
    results = DatabaseConnection.PostsforCommunity(widget.community);
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
            } else if (!snapshot.hasData) {
              return Center(
                  child: Text(
                'This community currently has no posts.',
                textAlign: TextAlign.center,
              ));
            } else if (snapshot.hasData) {
              final truePosts = snapshot.data as Results;

              return ListView(
                children: [
                  for (var element in truePosts)
                    Card(
                      color:
                          Color.fromARGB(255, 223, 223, 223).withOpacity(0.2),
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
                                    child: AutoSizeText(
                                      ' r/${element[3]} \n ${element[1]}',
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 2,
                                    )),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: AutoSizeText(
                                      '${DateFormat('yyyy-MM-dd').format(element[4])}',
                                      style: TextStyle(fontSize: 2),
                                      maxLines: 1,
                                    )),
                              ]),
                          ListTile(
                              title: Text('${element[5]}'),
                              subtitle: Text('${element[6]}')),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.blue),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ExpandedPostScreen(
                                            "community",
                                            '${element[0]}',
                                            '${element[1]}')));
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
