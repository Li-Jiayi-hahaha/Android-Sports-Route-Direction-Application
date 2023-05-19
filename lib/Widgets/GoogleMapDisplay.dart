import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/assets/db_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../palette.dart';

class GoogleMapDisplay extends StatefulWidget {
  @override
  _GoogleMapDisplayState createState() => _GoogleMapDisplayState();
}

class _GoogleMapDisplayState extends State<GoogleMapDisplay> {
  GoogleMapController mapController;
  final LatLng initialLocation = LatLng(1.28935742467591, 103.817334142586);
  LatLng position;

  @override
  Widget build(BuildContext context){
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
        child:
          GoogleMap(
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: initialLocation,
          ),

          onTap: (latLng) {
            position =  latLng;
            print('${position.toString()}');
          },
          //can zoom by gesture, no zoom control bars

          onMapCreated: (GoogleMapController controller) {
            mapController = controller; },
          ),
      );


  }
}