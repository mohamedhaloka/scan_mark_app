import 'dart:ui';

import 'package:flutter/cupertino.dart';

const kPrimaryColor = Color(0xff0E0E0E);

//User Collection
const String kUserCollection = "Users Collection";
const String kUserName = "user name";
const String kUserPhoto = "user photo";
const String kUserEmail = "user email";
const String kUserPassword = "user pass";


customHeight(context,heiNum)
{
  return MediaQuery.of(context).size.height*heiNum;
}

customWidth(context,wedNum)
{
  return MediaQuery.of(context).size.width*wedNum;
}