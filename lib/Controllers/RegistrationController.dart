import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/DAO/UserProfileDAO.dart';
import 'package:fitfeet/Entities/UserProfile.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/globals.dart';
import 'package:fitfeet/staticFactory.dart';
class RegistrationController {



  Future<String> _createAccount(String email, String password) async {
    DatabaseInterface dbConn= StaticFactory.createDatabaseInterface();
    String result = await dbConn.register(email, password);
    return result;
  }

  Future<List> register(String displayName, double weight, String email, String password,
      String gender, String dob) async {
    String result = await _createAccount(email, password);
    if (result == 'pass') {
      DatabaseInterface dbConn= StaticFactory.createDatabaseInterface();
      String uID = dbConn.getUID();
      userProfile = new UserProfile(uID, email, displayName, dob, gender, weight);
      UserProfileDAO userProfileDAO = StaticFactory.createUserProfileDAO();
      String result2 = await userProfileDAO.addRecord(userProfile);
      exerciseRecords = [];
      if (result2 == 'pass'){
        return [true,result2];
      }
      else
        return [false,result2];
      //homepage()
    }
    return [false, result];

  }
  /*void _persistenceSetter() async {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  }*/
}