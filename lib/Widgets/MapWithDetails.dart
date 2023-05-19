import 'dart:async';
import 'package:fitfeet/methods/GetPlace.dart';
import 'package:fitfeet/Controllers/PCNController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:fitfeet/globals.dart' as globals;


import 'package:fitfeet/Entities/PinInformation.dart';

import 'package:fitfeet/Controllers/LandmarksController.dart';
import 'MapPinPillComponent.dart';
import 'dart:math';


class MapWithDetails extends StatefulWidget {
  @override
  _MapWithDetails createState() => _MapWithDetails();
}


class _MapWithDetails extends State<MapWithDetails> {
  GoogleMapController _controller;
  Set<Marker> markers = {};

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(pinPath: '', location: '', name: '', type: '', labelColor: Colors.grey);
  PinInformation sourcePinInfo;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(1.2914, 103.7667),
    zoom: 15,
  );


  @override
  void initState() {
    super.initState();
  }

  void updateMap(PinInformation pin, double pos)
  {
    setState(() {
      currentlySelectedPin = pin;
      pinPillPosition = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
        child:
        Stack(
          children: <Widget>[
          GoogleMap(
            polylines: globals.polylines,
            markers: markers,
            mapType: MapType.normal,
            myLocationEnabled: true,

            initialCameraPosition: initialLocation,

            onTap: (latLng) {
                  setState(() {
                    pinPillPosition = -100;
                  });
                },

            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
              await PCNController().parsePCN();
              setState(() {
              });
              markers = await LandmarksController().getLandmarks(updateMap);
              setState(() {
              });
            },

          ),

            MapPinPillComponent(
                pinPillPosition: pinPillPosition,
                currentlySelectedPin: currentlySelectedPin
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            return Navigator.pushNamed(context, '/navigation');
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

    );
  }
}