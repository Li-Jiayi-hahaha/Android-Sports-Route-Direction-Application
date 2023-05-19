import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitfeet/Entities/ExerciseRecord.dart';
import '../globals.dart';
import 'package:fitfeet/Enumurators/StringToEnum.dart';

class ExerciseRecordDAOImpl implements ExerciseRecordDAO{
  final dbRef = FirebaseFirestore.instance.collection("UserProfiles").doc(FirebaseAuth.instance.currentUser.uid).collection('exercise record');


  static final ExerciseRecordDAOImpl _exerciseRecordDAOImpl = ExerciseRecordDAOImpl._internal();

  factory ExerciseRecordDAOImpl(){
    return _exerciseRecordDAOImpl;
  }
  ExerciseRecordDAOImpl._internal();

  Future<String> getAllRecords() async{
    List<ExerciseRecord> list = [];
    try{
        QuerySnapshot querySnapshot = await dbRef.get();
        if(querySnapshot.size>0){
            querySnapshot.docs.forEach((result){
            list.add(new ExerciseRecord(
              result.get("id"),
              result.get("timeElapsed"),
              result.get("level").toInt(),
              result.get("loopName"),
              result.get("distance"),
              result.get("caloriesBurned"),
                (result.get("result") == 'true' )? true:false,
              StringToEnum.convertExercise(result.get("exerciseType"))));
               });
            print("in exercise records constructor");
        }
        exerciseRecords = list;
        return "pass";
      } on FirebaseAuthException catch (e) {
          return "Could not retrieve collection snapshot: $e";
      }
  }
  Future<String> addRecord(ExerciseRecord record) async{
    try{
        await dbRef.doc("ExerciseRecord"+record.exerciseID.toString()).set(
            {
              "id": record.exerciseID,
              "timeElapsed": record.timeElapsed,
              "level": record.level,
              "loopName": record.loopName,
              "distance": record.distance,
              "caloriesBurned": record.caloriesBurned,
              "exerciseType": record.exerciseType.toString(),
              "result": record.result.toString()
          }
      );
      print("Exercise record added");
      return "pass";
      } on FirebaseAuthException catch (e){
           return "Failed to add exercise record: $e";
        }
    }

}

class ExerciseRecordDAO {
Future<String> addRecord(ExerciseRecord record) async{}
Future<String> getAllRecords() async{}

}