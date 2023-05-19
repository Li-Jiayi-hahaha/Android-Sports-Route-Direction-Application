import 'package:fitfeet/Widgets/ButtonBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/Widgets/GoogleMapDisplay.dart';
import 'package:fitfeet/Widgets/MapWithDetails.dart';
import 'package:fitfeet/assets/db_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../palette.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  void doNothing(position) { }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[

          MapWithDetails(),

          BottomToolBar(),

        ],
      )
    );
  }
}

