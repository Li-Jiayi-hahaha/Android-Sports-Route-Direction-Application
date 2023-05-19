import 'package:fitfeet/DAO/ExerciseRecordsDAO.dart';

import '../globals.dart';

class ExerciseRecordController {


  void updateExerciseRecord(){

    if(exerciseRecords.length==0){
      print("Fail: No exercise records to update.");
      return;
    }

    int id = exerciseRecords.length-1;

    exerciseRecords[id].distance = distanceTravelled;
    exerciseRecords[id].caloriesBurned = caloriesBurnt;
    exerciseRecords[id].timeElapsed = timeElapsed.toString();

    ExerciseRecordDAO exerciseRecordDAO = new ExerciseRecordDAOImpl();
    exerciseRecordDAO.addRecord(exerciseRecords[id]);

    print("Success: the newest exercise record is updated.");
    return;
  }

  void deleteRelatedRecord(){

    if(exerciseRecords.length==0){
      print("Fail: No exercise records to delete.");
      return;
    }
    int id = exerciseRecords.length-1;

    exerciseRecords.removeAt(id);
    print("Success: the newest exercise record is deleted.");
    return;

  }

}