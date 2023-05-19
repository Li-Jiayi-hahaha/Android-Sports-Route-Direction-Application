import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/Controllers/EmailVerification.dart';
import 'package:fitfeet/Controllers/LoginController.dart';
import 'package:fitfeet/Controllers/RegistrationController.dart';
import 'package:fitfeet/Controllers/ResetPasswordController.dart';
import 'package:fitfeet/Controllers/SignOutController.dart';
import 'package:fitfeet/Controllers/UpdateUserProfile.dart';
import 'package:fitfeet/DAO/ExerciseRecordsDAO.dart';
import 'package:fitfeet/DAO/LandmarkDAO.dart';
import 'Controllers/SignOutController.dart';
import 'DAO/RoutesDAO.dart';
import 'DAO/UserProfileDAO.dart';
import 'NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/globals.dart';
import 'NonDAOBoundary/FirebaseDBImpl.dart';

class StaticFactory{

  //Database connection
  static DatabaseInterface createDatabaseInterface(){
    if (database == "FB"){
      print("firebase");
      return FirebaseDBImpl();
    }
    else {
      return null;
    }
  }

  //DAO
  static UserProfileDAO createUserProfileDAO(){
    if (database == "FB"){
      return UserProfileDAOImpl();
    }
    else {
      return null;
    }
  }
  static BVLandmarkDAO createBVLandmarkDAO(){
    if (database=="FB"){
      return BVLandmarkDAOImpl();
    }
    else {
      return null;
    }
  }
  static ExerciseRecordDAO createExerciseRecordDAO(){
    if (database=="FB"){
      return ExerciseRecordDAOImpl();
    }
    else {
      return null;
    }
  }
  static RoutesDAO createRoutesDAO(){
    if (database=="FB"){
      return RoutesDAOImpl();
    }
    else {
      return null;
    }
  }
}