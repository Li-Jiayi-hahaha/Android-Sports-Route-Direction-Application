import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fitfeet/NonDAOBoundary/PCNInterface.dart';
import 'package:fitfeet/data/PCNlines.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:fitfeet/globals.dart' as globals;

class PCNController{

  Future<void> parsePCN() async {
    List colors = [Colors.orange, Colors.red, Colors.brown, Colors.purple, Colors.lightBlue, Colors.indigo];

    PCNLines pcnLines = new PCNLines();
    NetworkData networkData = new NetworkData();
    final Map<String, dynamic> parsed = await networkData.getNetworkData();

    var strID;
    var midID;
    int intID;
    int index;
    Polyline polyline;

    globals.polylines.clear();

    parsed['features'].forEach((parse) {
      List<LatLng> polylineCoordinates = [];
      parse['geometry']['coordinates'].forEach((element) {
        polylineCoordinates.add(LatLng(element[1], element[0]));
      });
      strID = parse['properties']['Name'].toString();
      midID = strID.replaceAll(new RegExp(r'[^0-9]'), '');
      intID = int.parse(midID);
      index = 0;

      if (pcnLines.waLoop.contains(intID)) {
        index = 0;
      }
      else if (pcnLines.srLoop.contains(intID)) {
        index = 1;
      }
      else if (pcnLines.neLoop.contains(intID)) {
        index = 2;
      }
      else if (pcnLines.nerLoop.contains(intID)) {
        index = 3;
      }
      else if (pcnLines.cuLoop.contains(intID)) {
        index = 4;
      }
      else if (pcnLines.ecLoop.contains(intID)) {
        index = 5;
      }

      polyline = Polyline(
          polylineId: PolylineId(parse['properties']['Name'].toString()),
          color: colors[index],
          width: 5,
          points: polylineCoordinates);

      globals.polylines.add(polyline);

    });

    print("--------Polylines added!!!!-------");

    int num = globals.polylines.length;
    print("--------# of polylines: $num--------");
  }
}

