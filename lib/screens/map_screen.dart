import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:mysql1/mysql1.dart';
import 'package:seniorproject/screens/community_screen.dart';

import '../utils/database_connection.dart';

List<String> communities = [
  'Academic Services',
  'Academic Support Facility',
  'Agroecology Research Community Garden',
  'Baseball Stadium',
  'Behavioral Neurosciences',
  'Central Utility Plant',
  'Chapel',
  'Child Development Center',
  'Computer Center',
  'Dining & Ballroom Complex',
  'Education Complex',
  'Emilia Schunior Ramirez Hall',
  'Engineering',
  'Engineering Portable',
  'Environmental Health & Safety',
  'Executive Tower',
  'Greenhouse',
  'H.E.B. Planetarium',
  'Health & Physical Education Complex Fieldhouse',
  'Health & Physical Education II',
  'Health Affairs Building East',
  'Health Affairs Building West',
  'Health Affairs Building West Auditorium',
  'Health Affairs Building West Classroom A',
  'Heritage Hall',
  'Interdisciplinary Engineering & Academic Building',
  'International Trade & Technology',
  'Intramural Fields',
  'Lamar E',
  'Liberal Arts Building North',
  'Liberal Arts Building South',
  'Marialice Shary Shivers',
  'Mathematics & General Classrooms',
  'Mathematics & Science Academy',
  'Medical Education-(School of Medicine)',
  'Orville Cox Tennis Center',
  'Performing Arts Complex A',
  'Performing Arts Complex B',
  'Performing Arts Complex C',
  'Physical Science',
  'Physical Science Portable',
  'Police and Parking & Transportation Offices',
  'Portable Buildings 9, 10, 11, 12, 13',
  'Research Education-(School of Medicine)',
  'Rio Grande Center for Manufacturing',
  'Robert C. Vackar College of Business and Entrepreneurship',
  'ROTC',
  'ROTC Storage',
  'Science',
  'Soccer and Track & Field Complex',
  'Social Work and Occupational Therapy',
  'Southwick Hall',
  'Student Academic Center',
  'Student Health Center',
  'Student Services Building',
  'Student Union',
  'Sugar Road Annex',
  'The Learning Center',
  'The Village A, B, C, D, E, F',
  'Thermal Storage Tank',
  'Track & Soccer Field',
  'Troxel Hall',
  'Unity Hall',
  'University Center',
  'University Library',
  'University Recreation',
  'Visitors Center'
];

List<LatLng> communityLocations = [
  LatLng(26.30534184489068, -98.1726210509522),
  LatLng(26.307736044578704, -98.17956795578824),
  LatLng(26.307922448321442, -98.17004265020437),
  LatLng(26.312062453456974, -98.17638694811335),
  LatLng(26.30775002088192, -98.17504732048133),
  LatLng(26.307989258750265, -98.17448942100691),
  LatLng(26.305312991451544, -98.17469171631546),
  LatLng(26.30811720452463, -98.16951425500949),
  LatLng(26.308162375286678, -98.17297665512523),
  LatLng(26.305169937301905, -98.17615108563722),
  LatLng(26.30849418126825, -98.17160336406037),
  LatLng(26.30585325783694, -98.17736882035639),
  LatLng(26.305731365631, -98.17204437602314),
  LatLng(26.305455321817057, -98.17126545400392),
  LatLng(26.30866752281921, -98.16712785211978),
  LatLng(26.30444978693559, -98.17403846385616),
  LatLng(26.307525721709894, -98.17008556555017),
  LatLng(26.306596962630184, -98.17192367660527),
  LatLng(26.306831650081083, -98.1700577183221),
  LatLng(26.30553346644637, -98.17007187100135),
  LatLng(26.30744947009675, -98.17418633136687),
  LatLng(26.307285970141407, -98.17546574508451),
  LatLng(26.307788491327813, -98.17566154631542),
  LatLng(26.307229466428296, -98.1754550162128),
  LatLng(26.306310101018926, -98.17744392221016),
  LatLng(26.306333309170473, -98.17482518638978),
  LatLng(26.30466498935264, -98.1694144700405),
  LatLng(26.309602925301036, -98.18013551907913),
  LatLng(26.30916247974254, -98.17423258526341),
  LatLng(26.307468705371768, -98.17630125316747),
  LatLng(26.306045995626135, -98.17596510308621),
  LatLng(26.30423097981333, -98.17528971437947),
  LatLng(26.30754684863113, -98.1729659262888),
  LatLng(26.304571212692675, -98.17530446652958),
  LatLng(26.31020089524413, -98.17514849321417),
  LatLng(26.304172072534485, -98.17073679913226),
  LatLng(26.304050643933117, -98.1721743285578),
  LatLng(26.30379817327817, -98.17318418027322),
  LatLng(26.304699851692163, -98.17268394828889),
  LatLng(26.305719811122625, -98.17397984951734),
  LatLng(26.30900460301416, -98.17099901522272),
  LatLng(26.308115939702535, -98.1796028245029),
  LatLng(26.305037132880045, -98.17197920512287),
  LatLng(26.309070844145044, -98.17512167112577),
  LatLng(26.308539112551244, -98.17947139626024),
  LatLng(26.30792193557595, -98.17355064787499),
  LatLng(26.310613213766427, -98.1744191858167),
  LatLng(26.310579552948862, -98.17395248147851),
  LatLng(26.307051398459393, -98.17212216007948),
  LatLng(26.30886330795975, -98.1831668148336),
  LatLng(26.303311266419144, -98.1695619915649),
  LatLng(26.304695045177013, -98.17270151722106),
  LatLng(26.304293509506255, -98.17594857885462),
  LatLng(26.309516827809926, -98.17753993601802),
  LatLng(26.30466258247997, -98.17422219518028),
  LatLng(26.305514965388717, -98.17524961581056),
  LatLng(26.306765740185224, -98.17838537757586),
  LatLng(26.30636295529401, -98.17307897602586),
  LatLng(26.30893102694855, -98.17776819350979),
  LatLng(26.308494061854653, -98.17371223675374),
  LatLng(26.304883795658995, -98.17097283349769),
  LatLng(26.306598632624794, -98.17740234796894),
  LatLng(26.30780336784838, -98.17795728925955),
  LatLng(26.304679427081595, -98.17639114335793),
  LatLng(26.30675650503612, -98.17389309660062),
  LatLng(26.31025977468002, -98.17773976057663),
  LatLng(26.304352405793434, -98.1743482590085),
];

String postComm = '';

//Dropdown for New Post Comms
class DropdownButtonComms extends StatefulWidget {
  const DropdownButtonComms({key});

  @override
  State<DropdownButtonComms> createState() => _DropdownButtonComms();
}

class _DropdownButtonComms extends State<DropdownButtonComms> {
  String dropdownValue = communities.first;
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
      items: communities.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const double _defaultLat = 26.3082;
  static const double _defaultLng = -98.1740;

  static const CameraPosition _defaultLocation =
      CameraPosition(target: LatLng(_defaultLat, _defaultLng), zoom: 15);
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  late final GoogleMapController _googleMapController;

  bool selectedValue = false;

  var postTitleTextController = TextEditingController();
  var postDescriptionTextController = TextEditingController();
  var postTitle = null;
  var postDescription = null;

  void _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _addMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('UTRGV Edinburg Campus'),
          position: _defaultLocation.target,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title: 'UTRGV Edinburg Campus', snippet: '5 Star Rating'),
        ),
      );
    });
  }

  Future<void> _moveToNewLocation() async {
    const _newPosition = LatLng(25.894138824294707, -97.48690867270119);
    _googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(_newPosition, 15));
    setState(() {
      const marker = Marker(
        markerId: MarkerId('UTRGV Brownsville Campus'),
        position: _newPosition,
        infoWindow: InfoWindow(
            title: 'UTRGV Brownsville Campus', snippet: '5 Star Rating'),
      );

      // _markers
      //   ..clear()
      //   ..add(marker);
    });
  }

  Future<void> _goToDefaultLocation() async {
    const _defultPosition = LatLng(_defaultLat, _defaultLng);
    _googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(_defultPosition, 15));
    setState(() {
      const marker = Marker(
        markerId: MarkerId('UTGRV Edinburg Campus'),
        position: _defultPosition,
        infoWindow: InfoWindow(
          title: 'UTGRV Edinburg Campus',
          snippet: '5 Star Rating',
        ),
      );

      // _markers
      //   ..clear()
      //   ..add(marker);
    });
  }

  late Future<Results> results;

  @override
  void initState() {
    super.initState();
    results = DatabaseConnection.GetCommunityRatings();
  }

  Set<Marker> markers(Results temp) {
    //final Set<Marker> tempMarkers = {};
    int count = 0;
    for (var element in temp) {
      var marker = Marker(
        markerId: MarkerId(communities[count]),
        position: communityLocations[count],
        infoWindow: InfoWindow(
          title: communities[count],
          snippet: '${element[0]} Safety Rating',
        ),
      );
      _markers.add(marker);
      count++;
    }
    return _markers;
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
              height: 400.0,
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
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 10),
                    child: Text(
                      'Select Ripple to Rate:',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DropdownButtonComms(),
                    ),
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
                            onPressed: () {
                              // DatabaseConnection.InsertPost(
                              //     widget.userName,
                              //     widget.userEmail,
                              //     postComm,
                              //     postTitleTextController.text,
                              //     postDescriptionTextController.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
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

  //fffdd385

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              key: Key("back-button"),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              icon: Icon(Icons.arrow_back_ios, color: Color(0xFFFFFFFF))),
          title: Text('Pond'),
          centerTitle: true,
          backgroundColor: Color(0xFFFF9E80),
          elevation: 0,
        ),
        body: FutureBuilder(
            future: results,
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
                  final trueRatings = snapshot.data as Results;
                  return Stack(
                    children: <Widget>[
                      GoogleMap(
                          onMapCreated: (controller) =>
                              _googleMapController = controller,
                          initialCameraPosition: _defaultLocation,
                          mapType: _currentMapType,
                          markers: markers(trueRatings) //markers(),
                          ),
                      Container(
                        padding: const EdgeInsets.only(top: 24, right: 12),
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                                onPressed: _changeMapType,
                                backgroundColor: Colors.green,
                                child: const Icon(Icons.map, size: 30.0)),
                            // const SizedBox(height: 20.0),
                            // FloatingActionButton(
                            //     onPressed: _addMarker,
                            //     backgroundColor: Colors.deepPurpleAccent,
                            //     child: const Icon(Icons.add_location, size: 36.0)),
                            const SizedBox(height: 20.0),
                            FloatingActionButton(
                                onPressed: _goToDefaultLocation,
                                backgroundColor: Colors.red,
                                child:
                                    const Icon(Icons.home_rounded, size: 36.0)),
                            const SizedBox(height: 20.0),
                            FloatingActionButton(
                                onPressed: () {
                                  _showDialogRatingSystem();
                                },
                                backgroundColor: Colors.amber,
                                child: const Icon(Icons.star, size: 36.0)),
                            const SizedBox(height: 20.0),
                            FloatingActionButton(
                                onPressed: _moveToNewLocation,
                                backgroundColor: Colors.indigoAccent,
                                child: const Icon(Icons.location_city,
                                    size: 36.0)),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
