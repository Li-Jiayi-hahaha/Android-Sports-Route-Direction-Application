import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/staticFactory.dart';

class ResetPasswordController{



  Future<List> resetPassword(String email) async {
    DatabaseInterface dbConn = StaticFactory.createDatabaseInterface();
    String result = await dbConn.sendResetPasswordEmail(email);
    if (result == 'pass') {
      return [true, result];
    }
    else {
      return [false, result];
    }
  }

}