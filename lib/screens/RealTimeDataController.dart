import 'dart:async';
import 'package:fitfeet/Widgets/ButtonBarBeforeNavigation.dart';
import 'package:fitfeet/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fitfeet/methods/CalculateDis.dart';
import 'package:fitfeet/Controllers/NoticeManager.dart';
import 'package:fitfeet/globals.dart' as globals;

class RealTimeDataController {
  static final RealTimeDataController _realTimeDataController = RealTimeDataController._internal();

  factory RealTimeDataController() {
    return _realTimeDataController;
  }

  RealTimeDataController._internal();

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

  static bool completed = false;
  String notice = "no notice recieved";

  static bool outOfRoute = false;

  final int routeSize = chosenRoute.route.length;
  LatLng routeEndPoint = chosenRoute.route[chosenRoute.route.length-1];

  void updateLocation(LocationData newLocalData, Function updateMap) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);

    String noticeText = notice;
    double meter = 1000* CalculateDis().calculateDistance(latlng.latitude, latlng.longitude, routeEndPoint.latitude, routeEndPoint.longitude);

    if(!completed) {

      if (meter <= 20) {
        completed = true;
      }

      else {

        noticeText = NoticeManager.getNoticeText(latlng);

        //print("noticeText: " + noticeText);

        if (noticeText != null) {

          print(outOfRoute);
          if (noticeText.compareTo("You've got out of route") == 0) {
            outOfRoute = true;

          }

          else {
            notice = noticeText;
          }
        }
      }
    }

    polylineCoordinates.add(latlng);
    updateMap(newLocalData, polylineCoordinates);
    }

  void getCurrentLocation(updateMap, _controller) async {
    S.start();

    try {
      var location = await _locationTracker.getLocation();
      updateLocation(location, updateMap);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
            if (_controller != null) {
              _controller.animateCamera(
                  CameraUpdate.newLatLng(LatLng(
                      newLocalData.latitude, newLocalData.longitude)));
              updateLocation(newLocalData, updateMap);

              if (once == 1) {
                oldLocation = newLocalData;
                once = 2;
              }

              //int MET = 4; //for walking
              caloriesBurnt =
                  S.elapsed.inSeconds * 3.5 * MET * userProfile.weight /
                      (255 * 60);
              distanceTravelled += calculateDistance(
                  oldLocation.latitude, oldLocation.longitude,
                  newLocalData.latitude, newLocalData.longitude);

              oldLocation = newLocalData;
            }
          });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  double calculateDistance(lat1, long1, lat2, long2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((long2 - long1) * p)) / 2;
    return 12742000 * asin(sqrt(a));
  }

  String printDuration() {
    Duration duration = S.elapsed;
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String printDistance() {
    if (distanceTravelled < 1000) {
      return "${distanceTravelled.toStringAsFixed(2)} m";
    }
    else {
      distanceTravelled = distanceTravelled / 1000;
      return "${distanceTravelled.toStringAsFixed(2)} km";
    }
  }

  String printCalories()
  {
    return caloriesBurnt.toStringAsFixed(2);
  }
}