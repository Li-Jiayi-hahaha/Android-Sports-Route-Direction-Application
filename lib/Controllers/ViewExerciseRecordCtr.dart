import 'package:flutter/material.dart';
import 'package:fitfeet/screens/ExerciseRecordPage.dart';

// Function to call to display bottom sheet to display history records page
void displayExerciseRecords(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Records();
      });
}