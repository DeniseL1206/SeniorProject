import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
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
            padding: EdgeInsets.only(left: 127), child: Text('Community')),
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
              }
              else if (value == 3) {
                //_showDialog();
              }
            },
          ),
        ],
      ),
      body: Column(children: [Card(
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
                  padding: EdgeInsets.fromLTRB(15, 11, 3, 3),
                  child: Text("The Visitor's Center Ripple",
                      style: TextStyle(fontSize: 20))),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: ElevatedButton(
                    style: 
                      ElevatedButton.styleFrom(primary: Color(0xFFFF9E80),
                      minimumSize: Size(80, 40)),
                    onPressed: () {},
                    child: const Text('Join'),
                  ),
              ),
            ]),
            ListTile(
              title: Text("Welcome to the Visitor's Center Ripple!"),
              subtitle: Text(
                  "Thank you for visiting this part of the pond. Feel free to interact with other koi and share a story if you feel comfortable in doing so. If otherwise, you are still welcome! Hopefully you'll feel comfortable to do so in the future. Create bonds throughout the pond!"),
            ),
          ],
        ),
      ),
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
    )
  ],)
    );
  }
}