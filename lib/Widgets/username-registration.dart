import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../palette.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
  }) : super(key: key);
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.grey[600].withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),),
      child: SizedBox(
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric
              (vertical: 10),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
            ),
            hintStyle: kBodyText,
          ),
          style: kBodyText,
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
