import  'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TapLocationWidget extends StatelessWidget {
  final updateStep;

  const TapLocationWidget({this.updateStep});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => updateStep(),
      onTapDown: (TapDownDetails details) => _onTapDown(details),
      onTapUp: (TapUpDetails details) => _onTapUp(details),
    );
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap down " + x.toString() + ", " + y.toString());
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());
  }
}