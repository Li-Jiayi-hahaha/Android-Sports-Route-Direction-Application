import 'package:google_maps_flutter/google_maps_flutter.dart';

class Route{
  List<LatLng> _route;
  String _name;
  String _loopName;
  int _level;


  Route(this._route, this._name, this._loopName, this._level);

  List<LatLng> get route => _route;

  set route(List<LatLng> value) {
    _route = value;
  }

  String get name => _name;

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  String get loopName => _loopName;

  set loopName(String value) {
    _loopName = value;
  }

  set name(String value) {
    _name = value;
  }
}