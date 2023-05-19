import 'package:fitfeet/Controllers/ExerciseRecordController.dart';
import 'package:fitfeet/Widgets/ButtonBar.dart';
import 'package:fitfeet/Widgets/ButtonBarInNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/Widgets/GoogleMapDisplay.dart';
import 'package:fitfeet/Widgets/MapWithDetails.dart';
import 'package:fitfeet/assets/db_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../globals.dart';
import '../palette.dart';
import '../Widgets/MapInNavigation.dart';
import 'HomeScreen.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationPage> {
  bool  completed = false;

  void deleteUserLocationPolyline(){

    print("Delete userLocation Line after navigation: ");
    Polyline find_poly;
    for(var poly in polylines)
    {
      if(poly.polylineId == PolylineId("userlocation"))
      {
        find_poly = poly;
        break;
      }
    }

    bool ifSuccess = polylines.remove(find_poly);

    print("Can remove poly? : " + ifSuccess.toString());
  }


  void changeCompleted(bool flag) {

    deleteUserLocationPolyline();

    //end navigation logic
    print("maintain exercise record.");

    /*ExerciseRecordController exerciseRecordController = new ExerciseRecordController();
    exerciseRecordController.updateExerciseRecord();

    print("go back to home page.");
    */


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void cancelNavigation(){

    deleteUserLocationPolyline();
    /*
    //cancel navigation
    print("maintain exercise record.");
    ExerciseRecordController exerciseRecordController = new ExerciseRecordController();
    exerciseRecordController.updateExerciseRecord();

    print("go back to home page.");
     */


    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void getOutOfRoute(){
    print("Get out of route.");
    //call jiajing function

    cancelNavigation();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.blue,

        body: Stack(
          children: <Widget>[

            MapInNavigation(completed, changeCompleted, getOutOfRoute),

            BottomToolBarInNavigation(completed, cancelNavigation),

          ],
        )
    );
  }
}



