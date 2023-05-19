import 'ExerciseType.dart';


class StringToEnum{

  static ExerciseType convertExercise(String value){
    String value2 = value.substring(13);
    print(value2);
    print(ExerciseType.values.firstWhere((element) => element.toString().split('.')[1].toUpperCase()==value2.toUpperCase()));
    return ExerciseType.values.firstWhere((element) => element.toString().split('.')[1].toUpperCase()==value2.toUpperCase());
  }
}