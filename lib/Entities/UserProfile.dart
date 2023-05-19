import 'ExerciseRecord.dart';
class UserProfile{
  String _userID;
  String _displayName;
  String _email;
  String _dob;
  String _gender;
  double _weight;
  bool _emailVerified = false;


  UserProfile(this._userID,this._email,this._displayName, this._dob,this._gender, this._weight){
    _userID = userID;
  }

  set emailVerified(bool value) {
    _emailVerified = value;
  }

  set weight(double value) {
    _weight = value;
  }

  set gender(String value) {
    _gender = value;
  }


  set dob(String value) {
    _dob = value;
  }

  set userID(String value) {
    _userID = value;
  }

  set displayName(String value) {
    _displayName = value;
  }
  String get email => _email;

  set email(String value) {
    _email = value;
  }


  bool get emailVerified => _emailVerified;

  double get weight => _weight;

  String get gender => _gender;

  String get dob => _dob;

  String get userID => _userID;

  String get displayName => _displayName;

}

