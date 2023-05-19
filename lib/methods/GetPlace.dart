import 'dart:async';
import 'package:geocoding/geocoding.dart';


class GetPlace{
  static Future<String> getPlace(lat, long) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(lat, long);
    Placemark placeMark = newPlace[0];

    String street = placeMark.street;
    String postalCode = placeMark.postalCode;
    String locality = placeMark.locality;
    String address = "${street}, ${postalCode}, ${locality}";

    return address;
  }
}


