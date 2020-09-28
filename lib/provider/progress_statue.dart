import 'package:flutter/cupertino.dart';

class ProgressStatue with ChangeNotifier {
  bool progress = false;

  changeVal(val) {
    progress = val;
    notifyListeners();
  }
}
