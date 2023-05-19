import 'package:latlng/latlng.dart';
import 'package:fitfeet/Enumurators/ExerciseType.dart';

class ExerciseRecord {
  int _exerciseID;
  String _timeElapsed;
  String _loopName;
  int _level;
  double _distance;
  double _caloriesBurned;
  ExerciseType _exerciseType;
  bool _result;

  bool get result => _result;

  set result(bool value) {
    _result = value;
  }
  ExerciseRecord(this._exerciseID, this._timeElapsed, this._level, this._loopName, this._distance, this._caloriesBurned,this._result, this._exerciseType);
  ExerciseRecord.fromExerciseRecord(this._exerciseID, this._level, this._loopName, this._exerciseType);

  ExerciseType get exerciseType => _exerciseType;

  set exerciseType(ExerciseType value) {
    _exerciseType = value;
  }

  double get caloriesBurned => _caloriesBurned;

  set caloriesBurned(double value) {
    _caloriesBurned = value;
  }

  double get distance => _distance;

  set distance(double value) {
    _distance = value;
  }

  int get level => _level;

  set level(int value) {
    _level = value;
  }

  String get loopName => _loopName;

  set loopName(String value) {
    _loopName = value;
  }

  String get timeElapsed => _timeElapsed;

  set timeElapsed(String value) {
    _timeElapsed = value;
  }

  int get exerciseID => _exerciseID;

  set exerciseID(int value) {
    _exerciseID = value;
  }
}


