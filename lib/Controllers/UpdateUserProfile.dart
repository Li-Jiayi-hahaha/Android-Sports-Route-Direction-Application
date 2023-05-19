import 'package:fitfeet/DAO/UserProfileDAO.dart';
import 'package:fitfeet/NonDAOBoundary/DatabaseInterface.dart';
import 'package:fitfeet/globals.dart';
import 'package:fitfeet/staticFactory.dart';

class UpdateUserProfileController{



  Future<List> updateHandler(String displayName, String gender,String dob,double weight) async {
    if(displayName!=null && displayName!=''){
     userProfile.displayName = displayName;
    }
    if (gender!=null) {
      userProfile.gender = gender;
    }
    if (dob!=null) {
      userProfile.dob = dob;
    }
    if (weight !=null) {
      userProfile.weight = weight;
    }
    UserProfileDAO userProfileDAO = StaticFactory.createUserProfileDAO();
    String result = await userProfileDAO.updateRecord(userProfile);
    if (result == 'pass'){
      return [true, "Particulars has updated successfully"];
    }
    else{
      return [false, result];
    }
  }
  Future<List> changeEmail(String email) async {
    if (email != userProfile.email) {
      DatabaseInterface dbConn= StaticFactory.createDatabaseInterface();
      String result = await dbConn.changeEmail(email);
      if (result == 'pass') {
        userProfile.email = email;
        userProfile.emailVerified = false;
        return [true, 'Email has updated successfully'];
      }
      else{
        return [false, result];
      }
    }
    else{
      return [true, 'Email has updated successfully'];
    }
  }
  Future<List> changePassword(String pw) async{
    DatabaseInterface dbConn= StaticFactory.createDatabaseInterface();
    String result = await dbConn.changePassword(pw);
    if (result == 'pass'){
      return [true, 'Password updated!'];
    }
    else{
      return [false, result];
    }
  }


  Future<List> reAuthenticateUser(String pw) async {
    DatabaseInterface dbConn= StaticFactory.createDatabaseInterface();
    String result = await dbConn.reAuthenticateUser(userProfile.email, pw);
    if (result == 'pass'){
      return [true,result];
    }
    else{
      return[false,result];
    }
  }

}