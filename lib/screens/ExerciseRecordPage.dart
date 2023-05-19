import 'package:flutter/material.dart';
import 'package:fitfeet/globals.dart';
import '../palette.dart';

class Records extends StatefulWidget {
  @override
  _Records createState() => _Records();
}

class _Records extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .70,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  Text("Exercise Records", style: kHeadTextBlack),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.black, size: 30,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 12.0)),
              Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: exerciseRecords.length,
                      itemBuilder: (context, index) {
                        var currentItem = exerciseRecords[index];
                        return Column(children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                          Text(currentItem.exerciseType.toString().split('.')[1], style: kBodyTextBlack),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Text("Loop: ${currentItem.loopName}", style: kBodyTextBlack),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Text("Level: ${currentItem.level}", style: kBodyTextBlack),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Text("Time Taken: ${currentItem.timeElapsed}", style: kBodyTextBlack),
                          //Text("Start: ${currentItem.startTime.toString().split('.')[0]}", style: kBodyTextBlack),
                          // Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          //Text("End: ${currentItem.endTime.toString().split('.')[0]}", style: kBodyTextBlack),
                          //Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          /*Text(
                              "Time elapsed: ${(currentItem.endTime.difference(
                                  currentItem.startTime)).toString().split('.')[0]}", style: kBodyTextBlack),*/
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Text("Distance Travelled: ${currentItem.distance}m", style: kBodyTextBlack),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Text("Calories burned: ${currentItem
                              .caloriesBurned}cal", style: kBodyTextBlack),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Text("Result: ${currentItem.result}", style: kBodyTextBlack),

                        ]
                        );
                      }
                  )
              )
            ]
        )
    );
  }
}
