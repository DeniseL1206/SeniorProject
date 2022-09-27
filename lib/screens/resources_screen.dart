// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final ScrollController _scrollController = ScrollController();

  Map<String, String> campusResources = {
    'Dean of Students': 'https://www.utrgv.edu/studentlife/dos/index.htm',
    'Counseling':
        'https://www.utrgv.edu/counseling/services/mental-health-counseling/index.htm',
    'Office for Advocacy & Violence Prevention': 'https://www.utrgv.edu/oavp/',
    'Office of Institutional Equity': 'https://www.utrgv.edu/equity/',
    'Vaqueros Report It':
        'https://www.utrgv.edu/en-us/student-experience/report-it/index.htm',
    'University Police': 'https://www.utrgv.edu/police/',
    'Health Services': 'https://www.utrgv.edu/health-services/',
  };

  Map<String, String> externalResources = {
    'National Suicide Prevention Hotline': 'https://988lifeline.org/',
    'National Sexual Assault Hotline': 'https://www.rainn.org/',
    'National Domestic Violence Hotline': 'https://www.thehotline.org/',
    'National Alliance on Mental Illness (NAMI) Helpline':
        'https://www.nami.org/help',
    'Family Crisis Center': 'https://www.familycrisisctr.org/',
    'Friendship of Women, Inc.': 'http://www.fowinc.com/'
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: IconButton(
                key: Key("back-button"),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF))),
            backgroundColor: Colors.blue,
            elevation: 0,
            bottom: const TabBar(
              key: Key("tabs"),
              tabs: [
                Tab(icon: Icon(Icons.school), key: Key("school-icon")),
                Tab(icon: Icon(Icons.north_east), key: Key("external-icon")),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: Column(
                    children: [
                      for (var item in campusResources.entries)
                        Card(
                            child: ListTile(
                                title: Text(
                                  item.key),
                                trailing: Icon(Icons.link, color: Colors.blue),
                                onTap: () async {
                                  String link = item.value;
                                  await launchUrlString(link);
                                })),
                    ],
                  )),
              Scrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  child: Column(
                    children: [
                      for (var item in externalResources.entries)
                        Card(
                            child: ListTile(
                                title: Text(item.key),
                                trailing: Icon(Icons.link, color: Colors.blue),
                                onTap: () async {
                                  String link = item.value;
                                  await launchUrlString(link);
                                })),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
