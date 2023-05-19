import 'package:fitfeet/Controllers/ExerciseRecordController.dart';
import 'package:fitfeet/Controllers/ViewExerciseRecordCtr.dart';
import 'package:fitfeet/Controllers/SignOutController.dart';
import 'package:fitfeet/Controllers/NoticeManager.dart';
import 'package:fitfeet/screens/HomeScreen.dart';
import 'package:fitfeet/screens/InNavigationPage.dart';
import 'package:fitfeet/screens/RealTimeDataController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/Widgets/GoogleMapDisplay.dart';
import 'package:fitfeet/Widgets/MapWithDetails.dart';
import 'package:fitfeet/assets/db_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../globals.dart';
import '../palette.dart';

class BottomToolBarBeforeNavigation extends StatefulWidget {
  final bool activated;
  final jumpTo;
  BottomToolBarBeforeNavigation(this.activated,this.jumpTo);
  @override
  _BottomToolBarBeforeNavigationState createState() => _BottomToolBarBeforeNavigationState();
}

class _BottomToolBarBeforeNavigationState extends State<BottomToolBarBeforeNavigation> {

  void deleteAllUserLocationPolyline(){

    print("Delete all userLocation Lines before navigation: ");

    bool ifSuccess = true;
    while(ifSuccess) {
      Polyline find_poly;
      for (var poly in polylines) {
        if (poly.polylineId == PolylineId("userlocation")) {
          find_poly = poly;
          break;
        }
      }

      ifSuccess = polylines.remove(find_poly);
    }

    //print("Can remove poly? : " + ifSuccess.toString());

  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      width: size.width,
      child: Container(
        //color: Colors.white,
        child: Center(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              FloatingActionButton.extended(
                heroTag: "btn_Before_1",
                onPressed: (){
                  if(widget.activated) {
                    print("Now jump to InNavigation Page");

                    NoticeManager.nextTuringPoint = -1;
                    RealTimeDataController.outOfRoute = false;
                    RealTimeDataController.completed = false;
                    //widget.jumpTo('/navigation');
                    //return Navigator.pushNamed(context, '/navigation');
                    deleteAllUserLocationPolyline();

                    //changed here
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage()));
                  }
                },
                backgroundColor: widget.activated? Colors.orange : Colors.grey,
                label: const Text("Start Navigation"),
              ),

              FloatingActionButton.extended(
                heroTag: "btn_Before_2",
                onPressed: (){

                  print("Now jump to Home Page");
                  //widget.jumpTo('/home');
                  //return Navigator.pushNamed(context, '/home');
                  ExerciseRecordController exerciseRecordController = new ExerciseRecordController();
                  exerciseRecordController.deleteRelatedRecord();

                  deleteAllUserLocationPolyline();

                  //changed here
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

                },
                backgroundColor: Colors.red,
                label: const Text("Cancel Navigation"),
              ),

            ],
          ),
        ),
      ),
    );

  }
}