import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';

// ignore: must_be_immutable
class FilledButton extends StatelessWidget {
  FilledButton(
      {@required this.tittle,
        @required this.onPress,
        @required this.buttonColor});
  String tittle;
  Function onPress;
  Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: customWidth(context, 1),
      child: RaisedButton(
        onPressed: onPress,
        child: Text(
          tittle,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        ),
        elevation: 0.0,
        highlightElevation: 0.0,
        color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}