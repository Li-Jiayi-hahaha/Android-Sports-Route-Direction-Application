library globals;
import 'Entities/ExerciseRecord.dart';
import 'package:fitfeet/Entities/Route.dart';
import 'Entities/Landmark.dart';
import 'Entities/UserProfile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Entities/Route.dart';

UserProfile userProfile;
List<ExerciseRecord> exerciseRecords =[];
List<BVLandmark> bvLandmarks;
String database = "FB";
List<Route> routes;
//Set<Polyline> polylines = {};
List<Set<Polyline>> routePaths;

//Set<Polyline> routeLines = {};
//int selectedRouteIndex;
double caloriesBurnt = 0;
double distanceTravelled = 0;
Duration timeElapsed;
Route chosenRoute;
Set<Polyline> polylines = {};

