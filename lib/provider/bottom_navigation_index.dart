
import 'package:flutter/cupertino.dart';

class ChangeIndex with ChangeNotifier{

  int initialIndex=0;

  changeIndex(val)
  {
    initialIndex =val;
    notifyListeners();
  }
}