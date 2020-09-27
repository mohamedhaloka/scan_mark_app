import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';

class CustomSizedBox extends StatelessWidget {
  CustomSizedBox({@required this.heiNum, @required this.wedNum});
  double heiNum;
  double wedNum;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: customHeight(context, heiNum),
      width: customWidth(context, wedNum),
    );
  }
}
