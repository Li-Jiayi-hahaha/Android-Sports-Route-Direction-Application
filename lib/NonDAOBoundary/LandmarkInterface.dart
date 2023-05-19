import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

class LandmarkData {

  Future fetchFacilities(int) async {
    if (int == 0)
    {
      final response = await http.get(Uri.parse(
          'https://geo.data.gov.sg/bicyclerack/2021/01/11/geojson/bicyclerack.geojson'),
      );
      return response.body;
    }
    else if (int == 1)
    {
      final response = await http.get(Uri.parse(
          'https://geo.data.gov.sg/sportsg-sport-facilities/2019/12/17/geojson/sportsg-sport-facilities.geojson'),
      );
      return response.body;
    }
    else if (int == 2)
    {
      final response = await rootBundle.loadString("assets/map.geojson");
      return response;
    }
  }
}

