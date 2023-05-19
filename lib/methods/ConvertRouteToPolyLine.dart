import 'dart:async';
import 'package:fitfeet/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteToPolyline{

  static void createPolyline(int id)
  {
    Polyline poly;
    poly = Polyline(
        polylineId: PolylineId("route " + id.toString()),
        color: Colors.black,
        width: 4,
        points: routes[id].route,
    );
  }
}

