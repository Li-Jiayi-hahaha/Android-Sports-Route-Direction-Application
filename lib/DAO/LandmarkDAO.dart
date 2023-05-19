import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlng/latlng.dart';
import 'package:fitfeet/Entities/Landmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitfeet/globals.dart';

class BVLandmarkDAOImpl implements BVLandmarkDAO {

  final dbRef = FirebaseFirestore.instance.collection('Landmarks');

  static final BVLandmarkDAOImpl _bvLandmarkDAOImpl = BVLandmarkDAOImpl._internal();

  factory BVLandmarkDAOImpl(){
    return _bvLandmarkDAOImpl;
  }
  BVLandmarkDAOImpl._internal();

  Future<String> getAllRecords() async {
    List<BVLandmark> list = [];
    try {
      QuerySnapshot querySnapshot = await dbRef.get();
      if (querySnapshot.size > 0) {
        querySnapshot.docs.forEach((result) {
          list.add(new BVLandmark(
              new LatLng(double.tryParse(result
                  .get("Latitude")), double.tryParse(result
                  .get("Longitude"))),
              result.get("Name"),
              bvLandmarkID: result.id));
        });
      }
      bvLandmarks = list;
      return "pass";
    } on FirebaseAuthException catch (e) {
      return "Could not retrieve Bicycle Vendors Landmark: $e";
    }
  }

}
class BVLandmarkDAO{
  Future<String> getAllRecords() async{}

}
