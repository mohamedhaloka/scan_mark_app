import 'dart:ui';

import 'package:flutter/cupertino.dart';

const kPrimaryColor = Color(0xff0E0E0E);


customHeight(context,heiNum)
{
  return MediaQuery.of(context).size.height*heiNum;
}

customWidth(context,wedNum)
{
  return MediaQuery.of(context).size.width*wedNum;
}