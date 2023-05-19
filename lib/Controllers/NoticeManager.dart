
//import 'dart:html';

import 'package:fitfeet/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:fitfeet/methods/CalculateDis.dart';

class NoticeManager{

  static int nextTuringPoint = -1;

  static String getNoticeText(LatLng userPos){

    print("Into GetNotice");

    CalculateDis calculateDis = new CalculateDis();
    //find nearest two points along the route

    double minDis = 9999999;
    int pointID;
    double meter;

    int routeSize = chosenRoute.route.length;
    LatLng routePos;

    LatLng prevPos, nextPos;

    for(int id = 0; id < routeSize; id++){

      routePos = chosenRoute.route[id];
      meter = 1000* calculateDis.calculateDistance(userPos.latitude, userPos.longitude, routePos.latitude, routePos.longitude);

      if(meter < minDis)
        {
          minDis = meter;
          pointID = id;
        }
    }

    //find adjacent route point

    if(pointID==routeSize-1)
      {
        return "No direction notice now.";
      }

    //LatLng prevPos;

    if(pointID == 0) {
      prevPos = chosenRoute.route[pointID];
      nextPos = chosenRoute.route[pointID+1];
    }

    else {

      prevPos = chosenRoute.route[pointID-1];
      routePos = chosenRoute.route[pointID];
      nextPos = chosenRoute.route[pointID+1];

      double dis_1 = 1000 * calculateDis.calculateDistance(
          prevPos.latitude, prevPos.longitude, routePos.latitude,
          routePos.longitude);

      double dis_2 = 1000 * calculateDis.calculateDistance(
          routePos.latitude, routePos.longitude, nextPos.latitude,
          nextPos.longitude);

      if(dis_1<dis_2) {
        prevPos = chosenRoute.route[pointID-1];
        nextPos = chosenRoute.route[pointID];
      }


      else {
        prevPos = chosenRoute.route[pointID];
        nextPos = chosenRoute.route[pointID + 1];
      }

    }

    //check if get out of route
    double dis_A = 1000* calculateDis.calculateDistance(userPos.latitude,
        userPos.longitude, prevPos.latitude, prevPos.longitude);

    double dis_B = 1000* calculateDis.calculateDistance(userPos.latitude,
        userPos.longitude, nextPos.latitude, nextPos.longitude);

    double dis_L = 1000* calculateDis.calculateDistance(prevPos.latitude,
        prevPos.longitude, nextPos.latitude, nextPos.longitude);

    double disToRoute = calculateDis.calPointLineDis(dis_A, dis_B, dis_L);

    print("disToRoute: " + disToRoute.toString());
    if(disToRoute>100)  return "You've got out of route";



    //check direction

    double angle_1 = calculateDis.calculateAngle(prevPos.latitude, prevPos.longitude, nextPos.latitude, nextPos.longitude);

    //if the last turning point is done

    if((nextTuringPoint!=-1)&&(pointID < nextTuringPoint))
    {
        print("point ID: "+ pointID.toString());
        print("next turning point: " + nextTuringPoint.toString());
        print("return null here");
        return null;
    }

    if((nextTuringPoint!=-1)&&(pointID >= nextTuringPoint))
    {
      nextTuringPoint = -1;
    }

    //find point 500 meters later

    meter = 0;

    int point_500ID = -1;
    for(int id = pointID+1; id < routeSize; id++){

      prevPos = chosenRoute.route[id-1];
      nextPos = chosenRoute.route[id];
      meter += 1000* calculateDis.calculateDistance(prevPos.latitude, prevPos.longitude, nextPos.latitude, nextPos.longitude);

      if(meter >= 100)
      {
        point_500ID = id;
        break;
      }
    }

    if(point_500ID==-1)
    {

      return "No direction notice now.";
    }

    prevPos = chosenRoute.route[point_500ID-1];
    nextPos = chosenRoute.route[point_500ID];

    double angle_2 = calculateDis.calculateAngle(prevPos.latitude, prevPos.longitude, nextPos.latitude, nextPos.longitude);

    int def_angle = angle_2.round() - angle_1.round();

    def_angle = (def_angle+720)%360;

    //if(def_angle<0) def_angle = (-1.0)*def_angle;

    print("Angle_1:  " + angle_1.toString());
    print("point ID 1: " + pointID.toString());

    print("Angle_2:  " + angle_2.toString());
    print("point ID 2: " + point_500ID.toString());

    prevPos = chosenRoute.route[pointID];
    nextPos = chosenRoute.route[point_500ID];
    meter = 1000* calculateDis.calculateDistance(prevPos.latitude, prevPos.longitude, nextPos.latitude, nextPos.longitude);

    print("Distance:  " + meter.toString());
    print("Difference:  " + def_angle.toString());

    print("next turning point: " + nextTuringPoint.toString());

    if((def_angle>220)&&(def_angle<315)) {
      nextTuringPoint = point_500ID-1;
      return "Turn Left Later";
    }
    if((def_angle>45)&&(def_angle<140)) {
      nextTuringPoint = point_500ID-1;
      return "Turn Right Later";
    }

    return "Go along the way";


  }


}