import 'package:flutter/material.dart';
import 'dart:async';

class NotificationsScreen extends StatefulWidget {
  String userEmail = '';
  // String userName = "";
  Widget userName;
  NotificationsScreen(this.userEmail, this.userName);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange.shade50,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Notifications'),
          backgroundColor: Color(0xFFFF9E80),
          elevation: 0,
        ),
        body: Container(
            child: Column(children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('redwhitekoifishavatar.jpg'),
                          )),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('2022-10-09'),
                      ),
                    ]),
                ListTile(
                  title: Text('Someone smiled at your post',
                      key: Key('notifications-text')),
                  subtitle:
                      Text('User abc enjoyed visiting your part of the pond'),
                ),
              ],
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('redwhitekoifishavatar.jpg'),
                          )),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('2022-10-09'),
                      ),
                    ]),
                ListTile(
                  title: Text('Someone has replied to your post'),
                  subtitle: Text(
                      'User abc has added another ripple to your part of the pond'),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('redwhitekoifishavatar.jpg'),
                          )),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('2022-10-09'),
                      ),
                    ]),
                ListTile(
                  title: Text('Someone cried to your post'),
                  subtitle: Text(
                      'User abc reacted to your post and added more more water to you part of the pond.'),
                ),
              ],
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          // Card(
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
          //             Spacer(),
          //             Padding(
          //               padding: EdgeInsets.all(12.0),
          //               child: Text('2022-10-09'),
          //             ),
          //           ]),
          //       ListTile(
          //         title: Text('Someone has reacted to your post'),
          //         subtitle:
          //             Text('User abc swam and visited your part of the pond'),
          //       ),
          //     ],
          //   ),
          //   elevation: 0,
          //   shape: RoundedRectangleBorder(
          //     side: BorderSide(
          //       color: Colors.grey.withOpacity(0.2),
          //       width: 1,
          //     ),
          //   ),
          // ),
        ])));
  }
}
