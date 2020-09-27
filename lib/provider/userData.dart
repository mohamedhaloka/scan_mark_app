
import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier{
  String name;
  String email;
  String pass;

  changeNameVal(val) {
    name = val;
    notifyListeners();
  }

  changeEmailVal(val) {
    email = val;
    notifyListeners();

  }

  changePassVal(val) {
    pass = val;
    notifyListeners();

  }
}
