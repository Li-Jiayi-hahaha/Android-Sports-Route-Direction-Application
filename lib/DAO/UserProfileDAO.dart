import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/Entities/UserProfile.dart';
import '../globals.dart';

class UserProfileDAOImpl implements UserProfileDAO{
  final _dbRef = FirebaseFirestore.instance.collection("UserProfiles");
  final _user = FirebaseAuth.instance.currentUser;

  static final UserProfileDAOImpl _userProfileDAOImpl = UserProfileDAOImpl._internal();

  factory UserProfileDAOImpl(){
    return _userProfileDAOImpl;
  }
  UserProfileDAOImpl._internal();

   Future<String> getRecord() async {
    try{
        String uID = _user.uid;
        DocumentSnapshot snapshot = await _dbRef.doc(uID).get();
        if(snapshot.exists){
            userProfile = new UserProfile(
                _user.uid,_user.email,snapshot.get("displayName"),
            snapshot.get("dob"),snapshot.get("gender"),snapshot.get("weight"));
            if (_user.emailVerified==true){
          userProfile.emailVerified = true;
        }
        return "pass";
      }
        else{
            print("User with id '$uID' does not exist on the database.");
            return "Failed to retrieve user's record.";
        }
      } on FirebaseAuthException catch (e) {
        return "Failed to retrieve user's record. $e";
      }
    }
    

  Future<String> addRecord(UserProfile userProfile) async{
    String uid = userProfile.userID;
    if (uid!=null) {
    try{
      await _dbRef.doc(userProfile.userID).set(
        {
          "displayName": userProfile.displayName,
          "dob": userProfile.dob,
          "gender": userProfile.gender,
          "weight": userProfile.weight,
        }
      );
      print("User profile added");
      return "pass";
      } on FirebaseAuthException catch (e){
           return "Failed to add user: $e";
        }
    }
    else{
      print("Exercise record with id '$uid' already exist in the database!");
    }
  }


  Future<String> updateRecord(UserProfile userProfile) async{
    try{
        await _dbRef.doc(userProfile.userID).update({
         "displayName": userProfile.displayName,
        "dob": userProfile.dob,
         "gender": userProfile.gender,
        "weight": userProfile.weight,
        });
        print("User Profile updated!");
        return "pass";
    } on FirebaseAuthException catch (e){
        return "Failed to update user profile: $e";
       }
    }

    Future<String> deleteRecord(String id) async{
        try{
            await _dbRef.doc(id).delete();
            return "pass";
        } on FirebaseAuthException catch (e){
            return "Failed to delete user profile: $e";
        }
    }
}

class UserProfileDAO{
  Future<String> getRecord() async{}
  Future<String> deleteRecord(String id) async{}
  Future<String> addRecord(UserProfile userProfile) async{}
  Future<String> updateRecord(UserProfile userProfile) async{}
}