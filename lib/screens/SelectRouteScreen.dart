import 'package:fitfeet/Controllers/SelectRouteController.dart';
import 'package:fitfeet/data/LoopName.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitfeet/assets/db_icons.dart';
import '../palette.dart';
import 'package:fitfeet/Enumurators/ExerciseType.dart';

import 'package:fitfeet/screens/BeforeNavigation.dart';



class InputRouteInfo extends StatefulWidget {
  @override
  _InputRouteInfoState createState() => _InputRouteInfoState();
}

class _InputRouteInfoState extends State<InputRouteInfo> {
  int level = 0;
  int loop = 0;
  ExerciseType exerciseType;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar (
          title: Text("Select exercise details"),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
      body:Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height-kToolbarHeight-24,
            //margin: EdgeInsets.fromLTRB(0,0,0,0),
            color: Colors.blue[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("    Select loop: (${loop+1}/6)",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),

                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      IconButton(
                          icon: const Icon(Icons.arrow_back_sharp,
                            color: Colors.black,),
                          onPressed: (){
                            if (loop == 0){}
                            else{
                              setState(() {
                                loop -= 1;
                              });}
                          }
                      ),
                      Spacer(),
                      Text(LoopNames().loopNames[loop],
                          style: TextStyle(fontSize: 20.0)),
                      Spacer(),
                      IconButton(
                          icon: const Icon(Icons.arrow_forward_sharp,
                            color: Colors.black,),
                          //counter check
                          onPressed: (){
                            if (loop == 5){}
                            else{
                              setState(() {
                                loop += 1;
                              });}
                          }
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("    Distance level: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ), //select type text

                  FloatingActionButton.extended(onPressed: (){
                    setState(() {
                      level = 1;
                    });
                  },
                    backgroundColor: (level == 1)? Colors.blue[900]:Colors.blue,

                    label: const Text("Level 1:  2 km"),
                  ),

                  FloatingActionButton.extended(onPressed: (){
                    setState(() {
                      level = 2;
                    });
                  },
                    backgroundColor: (level == 2)? Colors.blue[900]:Colors.blue,

                    label: const Text("Level 2:  4 km"),
                  ),

                  FloatingActionButton.extended(onPressed: (){
                    setState(() {
                      level = 3;
                    });
                  },
                    backgroundColor: (level == 3)? Colors.blue[900]:Colors.blue,

                    label: const Text("Level 3:  8 km"),
                  ),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("    Exercise type: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                  ],
                  ), //select type text

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      FloatingActionButton(onPressed: (){
                        setState(() {
                          exerciseType = ExerciseType.WALK;
                        });
                      },
                        backgroundColor: (exerciseType == ExerciseType.WALK)? Colors.blue[900]:Colors.blue,
                        child: Column(
                          children: [
                            Icon(NavigationScreen.changemodewalk,
                                size: 40.0
                            ),
                            Text("Walk",style: navScreenWhite),
                          ],
                        ),
                        elevation: 0.1,
                      ),

                      FloatingActionButton(onPressed: (){
                        setState(() {
                          exerciseType = ExerciseType.RUN;
                        });
                      },
                        backgroundColor: (exerciseType == ExerciseType.RUN)? Colors.blue[900]:Colors.blue,
                        child: Column(
                          children: [
                          Icon(NavigationScreen.changemoderun,
                          size: 40.0
                          ),
                          Text("Run",style: navScreenWhite),
                          ],
                        ),
                          elevation: 0.1,
                      ),

                      FloatingActionButton(onPressed: (){
                        setState(() {
                          exerciseType = ExerciseType.CYCLE;
                        });
                      },
                        backgroundColor: (exerciseType == ExerciseType.CYCLE)? Colors.blue[900]:Colors.blue,
                        child: Column(
                          children: [
                            Icon(NavigationScreen.changemodebike,
                                size: 40.0
                            ),
                            Text("Cycle",style: navScreenWhite),

                          ],
                        ),
                        elevation: 0.1,
                      ),


                    ],
                  ), //select type icons

                  FloatingActionButton.extended(
                    backgroundColor: Colors.orange,
                    onPressed: () async{
                      await SelectRouteController().addPolyline(loop, level);
                      SelectRouteController().addExerciseRecord(loop, level, exerciseType);

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BeforeNavigationPage()));
                    }, //press "start"
                    label: const Text("Select Route"),
                  ), //Start Navigation button


                  FloatingActionButton.extended(
                    backgroundColor: Colors.grey[400],
                    onPressed: (){
                      return Navigator.pushNamed(context, '/home');
                      }, //press "Cancel"
                          label: const Text("Cancel Navigation"),
                  ), //Cancel button


                ]
            ),
          ),


          //BottomToolBarContainer(),

        ],
      ),
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width*0.20, 0, size.width*0.35, 0);
    path.quadraticBezierTo(size.width*0.40, 0, size.width*0.40, 20);
    path.arcToPoint(Offset(size.width*0.60,20),
      radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width*0.60, 0, size.width*0.65, 0);
    path.quadraticBezierTo(size.width*0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

