import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinInformation {
  String pinPath;
  String location;
  String name;
  String type;
  Color labelColor;

  PinInformation({this.pinPath, this.location, this.type, this.name, this.labelColor});
}