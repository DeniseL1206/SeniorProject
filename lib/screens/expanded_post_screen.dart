import 'package:flutter/material.dart';
import 'dart:async';

class ExpandedPostScreen extends StatefulWidget {
  @override
  _ExpandedPostScreenState createState() => _ExpandedPostScreenState();
}

class _ExpandedPostScreenState extends State<ExpandedPostScreen> {

   final ScrollController _scrollController = ScrollController();

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
              icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF))),
          //title: Padding(
             // padding: EdgeInsets.only(left: 127), child: Text('')),
          backgroundColor: Color(0xFFFF9E80),
          elevation: 0,
          actions: [
          
          ],
        ),
        body: 
        SingleChildScrollView(
                  //isAlwaysShown: true,
                  controller: _scrollController,
                  child: Column(
          children: [Card(
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
          // TextButton(
          //                     style: TextButton.styleFrom(primary: Colors.blue),
          //                     onPressed: () {
          //                       setState(() {
          //                             Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => ExpandedPostScreen()));                            
          //                                                       });
          //                     },
          //                     child: const Text('View More...'),
          //                   ),
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
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.report_gmailerrorred),
                onPressed: () {
                  //_showDialogReport();
                },
              ),
            ],
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
                  title: Text('Someone smiled at your post', key: Key('notifications-text')),
                  subtitle: Text('User abc enjoyed visiting your part of the pond'),
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
                  title: Text('Someone smiled at your post', key: Key('notifications-text')),
                  subtitle: Text('User abc enjoyed visiting your part of the pond'),
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
          
          Column(children: <Widget> [Align(alignment: Alignment.bottomCenter, child: 
          Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: TextField(
                cursorColor: Color(0xFFFF9E80),
                //controller: myController,
                // onChanged: (inputValue) {
                //   if (inputValue.isEmpty) {
                //     button = true;
                //     //setValidator(true);
                //   } else {
                //     setValidator(false);
                //     button = false;
                //   }
                //   if (inputValue.contains(emailValidator)) {
                //     setValidator(true);
                //   }
                // },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFFFF9E80))
                  ),
                 // errorText:
                      //emailHandle ? null : "Please enter a valid utrgv email",
                  border: OutlineInputBorder(),
                  labelText: 'Comment',
                  labelStyle: TextStyle(color: Color(0xFFFF9E80)),
                  hintText: 'Add a comment',
                  hoverColor: Color(0xFFFF9E80),
                  focusColor: Color(0xFFFF9E80),
                  fillColor: Color(0xFFFF9E80),
                ),
              ), )
          
          )]),
          ])
          ),


    //     Column(
    //       children: [Card(
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
    //       Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    //         Padding(
    //             padding: EdgeInsets.all(12.0),
    //             child: CircleAvatar(
    //               backgroundImage: AssetImage('redwhitekoifishavatar.jpg'),
    //             )),
    //         Padding(
    //             padding: EdgeInsets.fromLTRB(1, 11, 3, 3),
    //             child: Text(' r/ESSBL \n firstuser@utrgv.edu',
    //                 style: TextStyle(fontSize: 15))),
    //         Spacer(),
    //         Padding(
    //           padding: EdgeInsets.all(12.0),
    //           child: Text('2022-10-09'),
    //         ),
    //       ]),
    //       ListTile(
    //         title: Text('Excited about the new app!'),
    //         subtitle: Text(
    //             'I am very happy that an application like this exists for the university. Definitely excited to implement this in my campus life.'),
    //       ),
    //       TextButton(
    //                           style: TextButton.styleFrom(primary: Colors.blue),
    //                           onPressed: () {
    //                             setState(() {
    //                                   Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (_) => ExpandedPostScreen()));                            
    //                                                             });
    //                           },
    //                           child: const Text('View More...'),
    //                         ),
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
    //               //_showDialogReport();
    //             },
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // ),
    // Card(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Row(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Padding(
    //                       padding: EdgeInsets.all(12.0),
    //                       child: CircleAvatar(
    //                         backgroundImage:
    //                             AssetImage('redwhitekoifishavatar.jpg'),
    //                       )),
    //                   Spacer(),
    //                   Padding(
    //                     padding: EdgeInsets.all(12.0),
    //                     child: Text('2022-10-09'),
    //                   ),
    //                 ]),
    //             ListTile(
    //               title: Text('Someone smiled at your post', key: Key('notifications-text')),
    //               subtitle: Text('User abc enjoyed visiting your part of the pond'),
    //             ),
    //           ],
    //         ),
    //         elevation: 0,
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //             color: Colors.grey.withOpacity(0.2),
    //             width: 1,
    //           ),
    //         ),
    //       ),
    //       Card(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             Row(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   Padding(
    //                       padding: EdgeInsets.all(12.0),
    //                       child: CircleAvatar(
    //                         backgroundImage:
    //                             AssetImage('redwhitekoifishavatar.jpg'),
    //                       )),
    //                   Spacer(),
    //                   Padding(
    //                     padding: EdgeInsets.all(12.0),
    //                     child: Text('2022-10-09'),
    //                   ),
    //                 ]),
    //             ListTile(
    //               title: Text('Someone smiled at your post', key: Key('notifications-text')),
    //               subtitle: Text('User abc enjoyed visiting your part of the pond'),
    //             ),
    //           ],
    //         ),
    //         elevation: 0,
    //         shape: RoundedRectangleBorder(
    //           side: BorderSide(
    //             color: Colors.grey.withOpacity(0.2),
    //             width: 1,
    //           ),
    //         ),
    //       ),
          
    //       Column(children: <Widget> [Align(alignment: Alignment.bottomCenter, child: 
    //       Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: TextField(
    //             cursorColor: Color(0xFFFF9E80),
    //             //controller: myController,
    //             // onChanged: (inputValue) {
    //             //   if (inputValue.isEmpty) {
    //             //     button = true;
    //             //     //setValidator(true);
    //             //   } else {
    //             //     setValidator(false);
    //             //     button = false;
    //             //   }
    //             //   if (inputValue.contains(emailValidator)) {
    //             //     setValidator(true);
    //             //   }
    //             // },
    //             decoration: InputDecoration(
    //               focusedBorder: OutlineInputBorder(
    //                 borderSide: BorderSide(width: 3, color: Color(0xFFFF9E80))
    //               ),
    //              // errorText:
    //                   //emailHandle ? null : "Please enter a valid utrgv email",
    //               border: OutlineInputBorder(),
    //               labelText: 'Comment',
    //               labelStyle: TextStyle(color: Color(0xFFFF9E80)),
    //               hintText: 'Add a comment',
    //               hoverColor: Color(0xFFFF9E80),
    //               focusColor: Color(0xFFFF9E80),
    //               fillColor: Color(0xFFFF9E80),
    //             ),
    //           ), )
          
    //       )]),
    //       ])
          
         
            
            

      //   Container(
      //    color: Colors.deepOrange.shade50,
      //    child: ListView.builder(
      //      itemCount: 1,
      //      itemBuilder: (context, i) {
      //        return Task();
      //      },
      //    ),
      //  ),
        
        );


  }
}
