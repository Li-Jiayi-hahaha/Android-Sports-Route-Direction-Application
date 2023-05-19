import 'package:latlng/latlng.dart';

class BVLandmark{
  String _bvLandmarkID;
  LatLng _position;
  String _name;

  BVLandmark( this._position, this._name, {bvLandmarkID=null}){
    _bvLandmarkID = bvLandmarkID;
  }

  set bvLandmarkID(String value) {
    _bvLandmarkID = value;
  }
  set name(String value) {
    _name = value;
  }
  set position(LatLng value) {
    _position = value;
  }

  String get name => _name;

  LatLng get position => _position;

  String get bvLandmarkID => _bvLandmarkID;

}