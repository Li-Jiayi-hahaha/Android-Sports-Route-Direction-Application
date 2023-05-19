import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/staticFactory.dart';

class EmailVerificationController{



  Future<String> verifyEmail() async{
    DatabaseInterface dbConn= StaticFactory.createDatabaseInterface();
    String result = await dbConn.verifyEmail();
    return result;
  }
}