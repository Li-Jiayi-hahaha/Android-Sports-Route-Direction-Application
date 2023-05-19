import 'package:fitfeet/Controllers/ExerciseRecordController.dart';
import 'package:fitfeet/Controllers/ViewExerciseRecordCtr.dart';
import 'package:fitfeet/Controllers/SignOutController.dart';
import 'package:fitfeet/screens/HomeScreen.dart';
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

class BottomToolBarInNavigation extends StatefulWidget {
  final bool completed;
  final cancelNavigation;
  BottomToolBarInNavigation(this.completed, this.cancelNavigation);

  @override
  _BottomToolBarInNavigationState createState() => _BottomToolBarInNavigationState();
}

class _BottomToolBarInNavigationState extends State<BottomToolBarInNavigation> {


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
                  child: FloatingActionButton.extended(
                    heroTag: "btn_InNav_1",
                    onPressed: (){
                      widget.cancelNavigation();
                     },
                    backgroundColor: Colors.red,
                    label: const Text("Cancel Navigation"),
              ),
            ),
      ),
    );

  }
}



