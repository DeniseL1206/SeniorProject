import 'package:flutter/material.dart';
import 'package:seniorproject/screens/community_screen.dart';
import 'dart:async';

const List<String> list = <String>[
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

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;
  String selectedCommunity = '';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      hint: Text("Swim to", key: Key('explorer-text')),
      value: null,
      icon: const Icon(Icons.water, color: Color(0xFFFF9E80)),
      elevation: 16,
      style: const TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.grey,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          selectedCommunity = value!;
          dropdownValue = selectedCommunity;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => CommunityScreen(selectedCommunity)));
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

class ExplorerScreen extends StatefulWidget {
  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  bool selectedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Explore'),
        backgroundColor: Color(0xFFFF9E80),
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          //gradient: LinearGradient(begin: Alignment.center, end: Alignment.bottomCenter, colors: Colors.orange),
          image: DecorationImage(
            image: AssetImage('KoiInWater.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

