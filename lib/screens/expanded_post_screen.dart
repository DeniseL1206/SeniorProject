import 'package:flutter/material.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mysql1/mysql1.dart';
import 'package:intl/intl.dart';
import '../utils/database_connection.dart';

const List<String> reportTypes = <String>[
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

class ExpandedPostScreen extends StatefulWidget {
  String previousScreen = '';
  String postGuid;
  String userName;
  ExpandedPostScreen(this.previousScreen, this.postGuid, this.userName);

  @override
  _ExpandedPostScreenState createState() => _ExpandedPostScreenState();
}

class _ExpandedPostScreenState extends State<ExpandedPostScreen> {
  final ScrollController _scrollController = ScrollController();
  late bool enabled;
  late bool visibleCount;
  final commentController = TextEditingController();
  bool submit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentController.addListener(() {
      setState(() {
        submit = commentController.text.isNotEmpty;
      });
    });
    if (widget.previousScreen == "home") {
      enabled = false;
      visibleCount = true;
    } else if (widget.previousScreen == "community") {
      enabled = true;
      visibleCount = false;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        //title: Padding(
        // padding: EdgeInsets.only(left: 127), child: Text('')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      // body: SingleChildScrollView(
      //   //isAlwaysShown: true,
      //   controller: _scrollController,
      //   child:
      body: Column(
        children: [
          Container(
              height: 190,
              color: Colors.deepOrange.shade50,
              child: PostGeneration(widget.postGuid, enabled, visibleCount)),
          SizedBox(height: 5),
          Expanded(
            flex: 4,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent)),
                height: 100,
                child: CommentGeneration(widget.postGuid)),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  cursorColor: Color(0xFFFF9E80),
                  controller: commentController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Color(0xFFFF9E80))),
                    border: OutlineInputBorder(),
                    labelText: 'Comment',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Add a comment...',
                    hoverColor: Color(0xFFFF9E80),
                    focusColor: Color(0xFFFF9E80),
                    fillColor: Color(0xFFFF9E80),
                    suffixIcon: MaterialButton(
                        onPressed: () async {
                          await DatabaseConnection.CommentOnPost(
                              widget.postGuid,
                              commentController.text,
                              widget.userName);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                        },
                        child: Icon(Icons.comment_outlined,
                            color: Color(0xFFFF9E80))),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

//Generation of Post Test Functions
class PostGeneration extends StatefulWidget {
  String postGuid = '';
  bool enabled;
  bool visibleCount;
  PostGeneration(this.postGuid, this.enabled, this.visibleCount);

  @override
  _PostGeneration createState() => _PostGeneration();
}

class _PostGeneration extends State<PostGeneration> {
  late Future<Results> results;

  @override
  void initState() {
    super.initState();
    results = DatabaseConnection.GetPostInfo(widget.postGuid);
  }

  @override
  Widget build(BuildContext context) {
    return Post(results, widget.postGuid, widget.enabled, widget.visibleCount);
  }
}

class Post extends StatefulWidget {
  Future<Results> post;
  String postGuid;
  bool enabled;
  bool visibleCount;
  Post(this.post, this.postGuid, this.enabled, this.visibleCount);

  @override
  _Post createState() => _Post();
}

class _Post extends State<Post> {
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
                                DatabaseConnection.ReportPost(widget.postGuid);
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.post,
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
              final truePost = snapshot.data as Results;

              return ListView(
                children: [
                  for (var element in truePost)
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color.fromARGB(255, 223, 223, 223)
                              .withOpacity(0.2),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                    Icons.sentiment_satisfied_alt_outlined),
                                onPressed: widget.enabled
                                    ? () {
                                        DatabaseConnection.SmileAtPost(
                                            '${element[0]}');
                                      }
                                    : null,
                              ),
                              Visibility(
                                visible: widget.visibleCount,
                                child: Text('${element[7]}',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon:
                                    Icon(Icons.sentiment_dissatisfied_outlined),
                                onPressed: widget.enabled
                                    ? () {
                                        DatabaseConnection.CryAtPost(
                                            '${element[0]}');
                                      }
                                    : null,
                              ),
                              Visibility(
                                visible: widget.visibleCount,
                                child: Text('${element[8]}',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: Icon(Icons.comment_outlined),
                                onPressed: null,
                              ),
                              Visibility(
                                visible: widget.visibleCount,
                                child: Text('${element[9]}',
                                    style: TextStyle(color: Colors.black)),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: Icon(Icons.report_gmailerrorred),
                                onPressed: widget.enabled
                                    ? () {
                                        _showDialogReport();
                                      }
                                    : null,
                              ),
                              Visibility(
                                visible: widget.visibleCount,
                                child: Text('${element[10]}',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ],
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

//Generate of Comments for Post

class CommentGeneration extends StatefulWidget {
  String postGuid = '';
  CommentGeneration(this.postGuid);

  @override
  _CommentGeneration createState() => _CommentGeneration();
}

class _CommentGeneration extends State<CommentGeneration> {
  late Future<Results> results;

  @override
  void initState() {
    super.initState();
    results = DatabaseConnection.Comments(widget.postGuid);
  }

  @override
  Widget build(BuildContext context) {
    return Comment(results, widget.postGuid);
  }
}

class Comment extends StatefulWidget {
  Future<Results> comment;
  String postGuid;

  Comment(this.comment, this.postGuid);

  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> {
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
                          title: const Text('Reporting Comment'),
                          content: Text(
                              'Are you sure you want to report this comment for ${reportValue}?'),
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
                                DatabaseConnection.ReportPost(widget.postGuid);
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.comment,
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
              final trueComment = snapshot.data as Results;

              return ListView(
                children: [
                  for (var element in trueComment)
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
                                      '\n ${element[2]}',
                                      style: TextStyle(fontSize: 13),
                                      maxLines: 2,
                                    )),
                                Spacer(),
                                Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: AutoSizeText(
                                      '${DateFormat('yyyy-MM-dd').format(element[3])}',
                                      style: TextStyle(fontSize: 2),
                                      maxLines: 1,
                                    )),
                              ]),
                          ListTile(
                              //title: Text('${element[5]}'),
                              subtitle: Text('${element[4]}')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                      Icons.sentiment_satisfied_alt_outlined),
                                  onPressed: () {
                                    DatabaseConnection.SmileAtPost(
                                        '${element[1]}');
                                  }),
                              Text('${element[5]}',
                                  style: TextStyle(color: Colors.black)),
                              const SizedBox(width: 4),
                              IconButton(
                                  icon: Icon(
                                      Icons.sentiment_dissatisfied_outlined),
                                  onPressed: () {
                                    DatabaseConnection.CryAtPost(
                                        '${element[1]}');
                                  }),
                              Text('${element[6]}',
                                  style: TextStyle(color: Colors.black)),
                              const SizedBox(width: 4),
                              IconButton(
                                  icon: Icon(Icons.report_gmailerrorred),
                                  onPressed: () {
                                    _showDialogReport();
                                  }),
                              Text('${element[7]}',
                                  style: TextStyle(color: Colors.black)),
                            ],
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
