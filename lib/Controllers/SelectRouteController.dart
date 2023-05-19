import 'package:fitfeet/DAO/RoutesDAO.dart';
import 'package:fitfeet/staticFactory.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'package:fitfeet/data/LoopName.dart';
import 'package:fitfeet/DAO/RoutesDAO.dart';
import '../globals.dart';
import 'package:fitfeet/Enumurators/ExerciseType.dart';
import 'package:fitfeet/Entities/ExerciseRecord.dart';


class SelectRouteController {

  Future addPolyline(int loop, int level) async{
    RoutesDAO findRoute = StaticFactory.createRoutesDAO();
    await findRoute.getRoute(LoopNames().loopNames[loop], level);

    Polyline poly = Polyline(
      polylineId: PolylineId(chosenRoute.name),
      color: Colors.black,
      width: 4,
      points: chosenRoute.route,
    );

    polylines.add(poly);

    poly = Polyline(
      polylineId: PolylineId("start point"),
      color: Colors.greenAccent,
      width: 6,
      points: chosenRoute.route.sublist(0,2),
    );

    polylines.add(poly);

    int routeSize = chosenRoute.route.length;

    poly = Polyline(
      polylineId: PolylineId("end point"),
      color: Colors.red,
      width: 6,
      points: chosenRoute.route.sublist(routeSize-2,routeSize),
    );

    polylines.add(poly);
}

  void addExerciseRecord(int loop, int level, ExerciseType exerciseType){
    int recordNo = exerciseRecords.length;
    ExerciseRecord newRecord = new ExerciseRecord.fromExerciseRecord(recordNo+1, level, LoopNames().loopNames[loop], exerciseType);
    exerciseRecords.add(newRecord);
  }
}