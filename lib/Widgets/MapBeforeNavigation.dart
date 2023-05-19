import 'dart:async';
import 'package:fitfeet/globals.dart';
import 'package:fitfeet/methods/CalculateDis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:fitfeet/globals.dart' as globals;

//import 'package:latlong/latlong.dart';

class MapBeforeNavigation extends StatefulWidget {

  final changeClickable;
  MapBeforeNavigation(this.changeClickable);

  @override
  _MapBeforeNavigation createState() => _MapBeforeNavigation();
}

class _MapBeforeNavigation extends State<MapBeforeNavigation> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Circle circle;
  GoogleMapController _controller;

  int once = 1;

  LatLng startLocation;

  Polyline polyline;
  List<LatLng> polylineCoordinates = [];

  final LatLng routeStartPoint = chosenRoute.route[0];



  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(1.2914, 103.7667),
    zoom: 20,
  );

  void updateLocation(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    polylineCoordinates.add(latlng);

    this.setState(() {
      circle = Circle(
          circleId: CircleId("userlocation"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });

    double meter = 1000* CalculateDis().calculateDistance(latlng.latitude, latlng.longitude, routeStartPoint.latitude, routeStartPoint.longitude);

    print("Meter dis:  "+ meter.toString());

    if(meter<=100)
      {
        //print("Call change clickable from Map widget");
        widget.changeClickable(true);
      }

    else{
      widget.changeClickable(false);
    }

  }

  void getCurrentLocation() async {

    try {
      var location = await _locationTracker.getLocation();

      updateLocation(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
            if (_controller != null) {
              _controller.animateCamera(
                  CameraUpdate.newLatLng(LatLng(
                      newLocalData.latitude, newLocalData.longitude)));
              updateLocation(newLocalData);

              if (once == 1)
              {
                startLocation = LatLng(newLocalData.latitude, newLocalData.longitude);
                once = 2;
              }
            }
          });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }


  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
          children: <Widget>[
            Container(

              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: GoogleMap(
                polylines: polylines,
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                circles: Set.of((circle != null) ? [circle] : []),
                onMapCreated: (GoogleMapController controller) async {
                  _controller = controller;
                  getCurrentLocation();
                },
              ),
            ),

            //BottomToolBarBeforeNavigation(),
          ]

      ),
      /*
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            globals.polylines.clear();
            return Navigator.pushNamed(context, '/home');
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

       */
    );

  }
}

