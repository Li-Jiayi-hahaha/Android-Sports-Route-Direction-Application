import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//D
class NetworkData
{
  static final NetworkData _networkData = NetworkData._internal();

  factory NetworkData() {
    return _networkData;
  }

  NetworkData._internal();

  Map<String, dynamic> parsed;
  bool downloaded = false;
  var response;

  Future<void> downloadPCN() async {
    response = await http.get( Uri.parse(
      'https://geo.data.gov.sg/park-connector-loop/2019/12/10/geojson/park-connector-loop.geojson'),
    );
    downloaded = true;
  }


  Future<Map<String, dynamic>> getNetworkData() async {
    if (downloaded) {
      return parsed = jsonDecode(response.body);
    }
    else {
      await downloadPCN();
      parsed = jsonDecode(response.body);
      return parsed;
    }
  }
}