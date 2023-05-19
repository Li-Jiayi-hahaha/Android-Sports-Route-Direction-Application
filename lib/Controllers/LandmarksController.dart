import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:fitfeet/methods/GetPlace.dart';
import 'package:fitfeet/globals.dart' as globals;
import 'package:fitfeet/NonDAOBoundary/LandmarkInterface.dart';

import 'package:fitfeet/data/SportFacilityNames.dart';
import 'package:fitfeet/Entities/PinInformation.dart';


class LandmarksController{
  LandmarkData landmarkData = new LandmarkData();

  GoogleMapController _controller;
//Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = {};

  BitmapDescriptor rackIcon;
  BitmapDescriptor facilityIcon;
  BitmapDescriptor rentalIcon;

  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(pinPath: '', location: '', name: '', type: '', labelColor: Colors.grey);
  PinInformation sourcePinInfo;

  List<PinInformation> rackSource = [];
  List<PinInformation> facilitySource = [];
  List<PinInformation> vendorSource = [];

  LatLng position;
  PolylinePoints polylinePoints = PolylinePoints();

  bool flag;

  Future setSourceIcons() async {
    rackIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/Bicycle_8.png");
    facilityIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/Basketball_Ball_8.png");
    rentalIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/Dollar_Sign_8.png");
  }

  Future<Set<Marker>> getLandmarks(Function updateMap) async {
    await setSourceIcons();
    for (int i=0; i<3; i++)
    {
      var response = await landmarkData.fetchFacilities(i);
      await parseFacilities(i, response, updateMap);
    }
    return markers;
  }

  Future<void> parseFacilities(i, response, updateMap) async {
    if (i == 0)
    {
      final Map<String, dynamic> parsed = jsonDecode(response);
      await Future.forEach(parsed['features'], (parse) async {
        var arr = parse['geometry']['coordinates'];
        var strID = parse['properties']['Name'].toString();
        var midID = strID.replaceAll(new RegExp(r'[^0-9]'),'');
        int intID = int.parse(midID);

        String address = await GetPlace.getPlace(arr[1], arr[0]);

          markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
              markerId: MarkerId("Bicycle Rack ${strID.toString()}"),
              position: LatLng(arr[1], arr[0]),
              onTap: () {
                  currentlySelectedPin = rackSource[intID-1];
                  pinPillPosition = 0;
                  updateMap(currentlySelectedPin, pinPillPosition);
              },
              icon: rackIcon
          ));

        rackSource.add(
            PinInformation(
                name: "Bicycle Rack ${intID.toString()}",
                location: address,
                type: "Bicycle Rack",
                pinPath: "assets/Bicycle Rack.jpg",
                labelColor: Colors.blueAccent
            )
        );
      });
    }
    else if (i == 1)
    {
      final Map<String, dynamic> parsed = jsonDecode(response);
      SportFacilityNames facilityNames = new SportFacilityNames();

      await Future.forEach(parsed['features'], (parse) async {
        await Future.forEach(parse['geometry']['coordinates'], (element) async {
          var strID = parse['properties']['Name'].toString();
          var midID = strID.replaceAll(new RegExp(r'[^0-9]'), '');
          int intID = int.parse(midID);

          String address = await GetPlace.getPlace(element[0][1], element[0][0]);


            markers.add(
                Marker(
                  // This marker id can be anything that uniquely identifies each marker.
                    markerId: MarkerId("Sport Facility ${strID.toString()}"),
                    position: LatLng(element[0][1], element[0][0]),
                    onTap: () {
                        currentlySelectedPin = facilitySource[intID-1];
                        pinPillPosition = 0;
                        updateMap(currentlySelectedPin, pinPillPosition);

                    },
                    icon: facilityIcon
                ));

          facilitySource.add(
              PinInformation(
                  name: "${facilityNames.facilityNames[intID-1]}",
                  location: address,
                  type: "Sports Facility",
                  pinPath: "assets/Sport Facility.jpg",
                  labelColor: Colors.blueAccent
              )
          );
        });
      });
    }
    else if (i == 2)
    {
      final Map<String, dynamic> parsed = jsonDecode(response);
      await Future.forEach(parsed['features'], (parse) async {
        var arr = parse['geometry']['coordinates'];
        var strID = parse['properties']['Name'].toString();
        var midID = strID.replaceAll(new RegExp(r'[^0-9]'),'');
        int intID = int.parse(midID);

        String address = await GetPlace.getPlace(arr[1], arr[0]);


          markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
              markerId: MarkerId("Bicycle Rental ${strID.toString()}"),
              position: LatLng(arr[1], arr[0]),
              onTap: () {
                  currentlySelectedPin = vendorSource[intID-1];
                  pinPillPosition = 0;
                  updateMap(currentlySelectedPin, pinPillPosition);
              },
              icon: rentalIcon
          ));

        vendorSource.add(
            PinInformation(
                name: "Bicycle Rental ${intID.toString()}",
                location: address,
                type: "Bicycle Rental",
                pinPath: "assets/Bicycle Vendor.jpg",
                labelColor: Colors.blueAccent
            )
        );
      });
    }
  }
}
