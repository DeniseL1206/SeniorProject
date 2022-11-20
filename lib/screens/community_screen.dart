import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:seniorproject/utils/database_connection.dart';
import 'package:seniorproject/screens/expanded_post_screen.dart';

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

  CommunityScreen(this.selectedCommunity);
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  var postTitleTextController = TextEditingController();
  var postDescriptionTextController = TextEditingController();
  var postTitle = null;
  var postDescription = null;
  final ScrollController _scrollController = ScrollController();

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
                          child: const Text("Post"))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                            onPressed: () {
                              //DatabaseConnection.InsertPost(user_guid, community_guid, post);
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

  bool selectedValue = false;

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
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF))),
        title: Padding(
            padding: EdgeInsets.only(left: 100), child: Text('Community')),
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
                //_showDialog();
              } else if (value == 3) {
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
            Card(
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
                        // Spacer(),
                        // Padding(
                        //   padding: EdgeInsets.all(12.0),
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         primary: Color(0xFFFF9E80),
                        //         minimumSize: Size(40, 20)),
                        //     onPressed: () {},
                        //     child: const Text('Join'),
                        //   ),
                        // ),
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
                            onPressed: () {
                              //DatabaseConnection.JoinCommunity(user_guid, community_guid);
                            },
                            child: const Text('Join'),
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

             Container(
              color: Colors.deepOrange.shade50,
              child: PostGeneration(widget.selectedCommunity)

              ),

            // Card(
            //   elevation: 0,
            //   shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //       color: Colors.grey.withOpacity(0.2),
            //       width: 1,
            //     ),
            //     //borderRadius: const BorderRadius.all(Radius.circular(12)),
            //   ),
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       Row(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Padding(
            //                 padding: EdgeInsets.all(12.0),
            //                 child: CircleAvatar(
            //                   backgroundImage:
            //                       AssetImage('redwhitekoifishavatar.jpg'),
            //                 )),
            //             Padding(
            //                 padding: EdgeInsets.fromLTRB(1, 11, 3, 3),
            //                 child: Text(' r/ESSBL \n firstuser@utrgv.edu',
            //                     style: TextStyle(fontSize: 15))),
            //             Spacer(),
            //             Padding(
            //               padding: EdgeInsets.all(12.0),
            //               child: Text('2022-10-09'),
            //             ),
            //           ]),
            //       ListTile(
            //         title: Text('Excited about the new app!'),
            //         subtitle: Text(
            //             'I am very happy that an application like this exists for the university. Definitely excited to implement this in my campus life.'),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: <Widget>[
            //           IconButton(
            //             icon: Icon(Icons.sentiment_satisfied_alt_outlined),
            //             onPressed: () {/* ... */},
            //           ),
            //           const SizedBox(width: 8),
            //           IconButton(
            //             icon: Icon(Icons.sentiment_dissatisfied_outlined),
            //             onPressed: () {/* ... */},
            //           ),
            //           const SizedBox(width: 8),
            //           IconButton(
            //             icon: Icon(Icons.comment_outlined),
            //             onPressed: () {/* ... */},
            //           ),
            //           const SizedBox(width: 8),
            //           IconButton(
            //             icon: Icon(Icons.report_gmailerrorred),
            //             onPressed: () {
            //               _showDialogReport();
            //             },
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      //),

      //   Container(
      //    color: Colors.deepOrange.shade50,
      //    child: ListView.builder(
      //      itemCount: 1,
      //      itemBuilder: (context, i) {
      //        return Task();
      //      },
      //    ),
      //  ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialogNewPost();
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
                        //borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                                    child: //Text(' r/ESSBL \n firstuser@utrgv.edu',
                                        Text(
                                            ' r/${element[2]} \n ${element[1]}',
                                            style: TextStyle(fontSize: 15))),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: //Text('2022-10-09'),
                                        Text('${element[3]}')),
                              ]),
                          ListTile(
                              title: //Text('Excited about the new app!'),
                                  Text('${element[4]}'),
                              subtitle: //Text(
                                  //'I am very happy that an application like this exists for the university. Definitely excited to implement this in my campus life.'),
                                  Text('${element[5]}')),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.blue),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ExpandedPostScreen()));
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
