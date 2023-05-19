import 'package:fitfeet/Widgets/ButtonBar.dart';
import 'package:fitfeet/Widgets/ButtonBarBeforeNavigation.dart';
import 'package:fitfeet/Widgets/MapBeforeNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfeet/Widgets/GoogleMapDisplay.dart';
import 'package:fitfeet/Widgets/MapWithDetails.dart';
import 'package:fitfeet/assets/db_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../palette.dart';

class BeforeNavigationPage extends StatefulWidget {
  @override
  _BeforeNavigationScreenState createState() => _BeforeNavigationScreenState();
}

class _BeforeNavigationScreenState extends State<BeforeNavigationPage> {

  bool clickable = false;
  //MapBeforeNavigation _mapBeforeNavigation;
  //BottomToolBarBeforeNavigation _bottomToolBarBeforeNavigation;

  void changeClickable(bool flag) {

    //print("Set clickable to TRUE in screen widget");
    setState(() {
      clickable = flag;
    });
  }

  void returnTo(String str)
  {
    Navigator.pushNamed(context, str);
  }

  @override
  void initState(){
    super.initState();
    //_mapBeforeNavigation = new MapBeforeNavigation(changeClickable);
    //_bottomToolBarBeforeNavigation = new BottomToolBarBeforeNavigation(clickable, returnTo);
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[

          MapBeforeNavigation(changeClickable),

          BottomToolBarBeforeNavigation(clickable, returnTo),

        ],
      )
    );
  }
}

