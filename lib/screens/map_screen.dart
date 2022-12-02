import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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
            markerId: MarkerId('defaultLocation'),
            position: _defaultLocation.target,
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(
                title: 'UTRGV Edinburg Campus', snippet: "5 Star Rating")),
      );
    });
  }

  Future<void> _moveToNewLocation() async {
    const _newPosition = LatLng(25.901747, -97.497482);
    _googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(_newPosition, 15));
    setState(() {
      const marker = Marker(
        markerId: MarkerId('newLocation'),
        position: _newPosition,
        infoWindow: InfoWindow(
            title: 'UTRGV Brownsville Campus', snippet: '5 Star Rating'),
      );

      _markers
        ..clear()
        ..add(marker);
    });
  }

  Future<void> _goToDefaultLocation() async {
    const _defultPosition = LatLng(_defaultLat, _defaultLng);
    _googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(_defultPosition, 15));
    setState(() {
      const marker = Marker(
        markerId: MarkerId('My Default Location'),
        position: _defultPosition,
        infoWindow: InfoWindow(
            title: 'UTGRV Edinburg Campus', snippet: '5 Star Rating'),
      );

      _markers
        ..clear()
        ..add(marker);
    });
  }

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
          title:
              Padding(padding: EdgeInsets.only(left: 158), child: Text('Pond')),
          backgroundColor: Color(0xFFFF9E80),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: (controller) => _googleMapController = controller,
              initialCameraPosition: _defaultLocation,
              mapType: _currentMapType,
              markers: _markers,
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
                  const SizedBox(height: 20.0),
                  FloatingActionButton(
                      onPressed: _addMarker,
                      backgroundColor: Colors.deepPurpleAccent,
                      child: const Icon(Icons.add_location, size: 36.0)),
                  const SizedBox(height: 20.0),
                  FloatingActionButton(
                      onPressed: _moveToNewLocation,
                      backgroundColor: Colors.indigoAccent,
                      child: const Icon(Icons.location_city, size: 36.0)),
                  const SizedBox(height: 20.0),
                  FloatingActionButton(
                      onPressed: _goToDefaultLocation,
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.home_rounded, size: 36.0)),
                ],
              ),
            )
          ],
        ));
  }
}
