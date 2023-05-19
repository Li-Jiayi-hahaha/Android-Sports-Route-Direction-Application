import 'dart:math' show sin, cos, sqrt, asin, atan2, pi;


class CalculateDis {

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  double calculateAngle(lat1, lon1, lat2, lon2)
  {
    var p = 0.017453292519943295;
    lat1 = lat1 * p;
    lon1 = lon1 * p;
    lat2 = lat2 * p;
    lon2 = lon2 * p;

    var dL = lon2 - lon1;

    var X = cos(lat2)* sin(dL);
    var Y = cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)* cos(dL);

    double bearing = atan2(X,Y);

    bearing = bearing*180.0/pi;

    //if(bearing<0) bearing += 360.0;

    return bearing;
  }

  double calPointLineDis (double a, double b, double c)
  {
    double area = 0.25 * sqrt((a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c));

    return 2.0*area/c;
  }

}