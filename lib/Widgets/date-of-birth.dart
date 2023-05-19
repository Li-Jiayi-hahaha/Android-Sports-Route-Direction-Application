import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateOfBirth extends StatefulWidget {
  @override
  _DateOfBirthState createState() => _DateOfBirthState();
}

class _DateOfBirthState extends State<DateOfBirth> {

  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: 600.0,
      child: Scaffold(
        body: CupertinoDatePicker(
            initialDateTime: _dateTime,
            onDateTimeChanged: (dateTime){
            print(dateTime);
              setState(() {
                _dateTime =dateTime;
              });
        })
      ),
    );
  }
}
