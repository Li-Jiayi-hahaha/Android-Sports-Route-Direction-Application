import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/staticFactory.dart';

class SignOutController{



  Future<void> signOut() async {
    DatabaseInterface dbConn = StaticFactory.createDatabaseInterface();
    return await dbConn.signOut();
  }
}