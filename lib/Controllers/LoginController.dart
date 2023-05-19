import 'package:fitfeet/DAO/ExerciseRecordsDAO.dart';
import 'package:fitfeet/DAO/UserProfileDAO.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/staticFactory.dart';

import '../globals.dart';

class LoginController {


  Future<List> login(String email, String password) async {
    DatabaseInterface dbConn = StaticFactory.createDatabaseInterface();
    String result = await dbConn.login(email, password);
    if(result=='pass') {
      String result2 = await _getUserData();
      if (result2=='pass') {
        return [true,result2];
      }
      else{
        return [false,result2];
      }
    }
    else{
      return [false,result];
    }
    //homepage()
  }





  Future<String> _getUserData() async {
    UserProfileDAO userProfileDAO = StaticFactory.createUserProfileDAO();
    String result1 = await userProfileDAO.getRecord();
    ExerciseRecordDAO exerciseRecordDAO = StaticFactory.createExerciseRecordDAO();
    String result2 = await exerciseRecordDAO.getAllRecords();
    if (exerciseRecords == null){
      exerciseRecords = [];
    }
    if (result1 != 'pass' || result2 != 'pass'){
      return 'Failed to retrieve user\'s records. Please re-launch the application';
    }
    else{
      return 'pass';
    }
  }

  /*void _persistenceSetter()  {
    FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  }*/
}
