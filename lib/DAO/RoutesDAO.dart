import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fitfeet/Entities/Route.dart';

import '../globals.dart';

class RoutesDAOImpl implements RoutesDAO {
  final _dbRef = FirebaseFirestore.instance.collection('Routes');

  static final RoutesDAOImpl _routesDAOImpl = RoutesDAOImpl._internal();

  factory RoutesDAOImpl(){
    return _routesDAOImpl;
  }
  RoutesDAOImpl._internal();

  Future<String> getRoute(String loopName, int level) async {
    try {
      QuerySnapshot querySnapshot = await _dbRef.where(
          'Loop Name', isEqualTo: loopName)
          .where('Level', isEqualTo: level)
          .get();
      print(querySnapshot.size);
      if (querySnapshot.size == 1) {
        querySnapshot.docs.forEach((result) {
          chosenRoute = new Route(
              parseCoord(result.get("Coordinates")),
              result.get("Name"),
              result.get("Loop Name"),
              result.get("Level"));
        });
      }
    }
    on FirebaseAuthException catch (e) {
      return "Could not retrieve collection snapshot: $e";
    }
  }


  List<LatLng> parseCoord(String value) {
    List<String> list1 = value.split(']');
    List<LatLng> list2 = [];

    String substring = list1[0].substring(1, list1[0].length - 2);
    List<String> list3 = substring.split(',');
    list2.add(LatLng(double.tryParse(list3[1]), double.tryParse(list3[0])));


    list1.removeAt(list1.length - 1);
    list1.removeAt(0);


    list1.forEach((element) {
      String substring = element.substring(2, element.length - 2);
      List<String> list3 = substring.split(',');
      list2.add(LatLng(double.tryParse(list3[1]), double.tryParse(list3[0])));
    });

    return list2;
  }

}

class RoutesDAO{
  Future<String> getRoute(String loopnName, int level) async{}

}