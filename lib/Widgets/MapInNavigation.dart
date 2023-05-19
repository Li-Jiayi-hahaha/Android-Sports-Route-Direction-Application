import 'dart:async';
import 'package:fitfeet/globals.dart';
import 'package:fitfeet/screens/RealTimeDataController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:fitfeet/globals.dart' as globals;

class MapInNavigation extends StatefulWidget {
  final bool completed;

  final changeCompleted;
  final cancelNavigation;
  MapInNavigation(this.completed, this.changeCompleted, this.cancelNavigation);
  @override
  _MapInNavigation createState() => _MapInNavigation();
}

class _MapInNavigation extends State<MapInNavigation> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Circle circle;
  GoogleMapController _controller;

  int once = 1;
  Stopwatch S = new Stopwatch();
  double caloriesBurnt = 0;
  double distanceTravelled = 0;
  LatLng startLocation;
  LocationData oldLocation;

  Polyline polyline;
  List<LatLng> polylineCoordinates = [];

  int MET = 4; //for walking

  //bool completed = false;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(1.2914, 103.7667),
    zoom: 20,
  );

  void updateMap(newLocalData, polylineCoordinates)
  {
    //print(RealTimeDataController().completed);
    if ( (RealTimeDataController.completed == true)  && (widget.completed==false))
    {
      print("route completed!");
      widget.changeCompleted(true);
    }

    //check if get out of route
    if (RealTimeDataController.outOfRoute == true)
    {
      print("Find get out of route in Map!");
      widget.cancelNavigation();
    }

    if(mounted) {
      setState(() {
        circle = Circle(
            circleId: CircleId("userlocation"),
            radius: newLocalData.accuracy,
            zIndex: 1,
            strokeColor: Colors.blue,
            center: LatLng(newLocalData.latitude, newLocalData.longitude),
            fillColor: Colors.blue.withAlpha(70));
        polyline = Polyline(
            polylineId: PolylineId("userlocation"),
            color: Colors.green,
            width: 4,
            points: polylineCoordinates);


        print("Delete userLocation Line before cover it: ");
        Polyline find_poly;
        for (var poly in globals.polylines) {
          if (poly.polylineId == PolylineId("userlocation")) {
            find_poly = poly;
            break;
          }
        }

        bool ifSuccess = polylines.remove(find_poly);

        print("Can remove poly? : " + ifSuccess.toString());

        globals.polylines.add(polyline);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RealTimeDataController().notice),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
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

                  if(mounted)
                    RealTimeDataController().getCurrentLocation(updateMap, _controller);

                  //check if completed


                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: new Text(" Distance Travelled: ${RealTimeDataController().printDistance()} \n Time Elapsed: ${RealTimeDataController().printDuration()}\n Calories Burnt: ${RealTimeDataController().printCalories()} kCal"),
            ),


          ]
      ),
    );
  }
}