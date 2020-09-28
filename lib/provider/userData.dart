import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  String name;
  String email;
  String pass;
  String phone;
  String address;

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

  changePhoneVal(val) {
    phone = val;
    notifyListeners();
  }

  changeAddressVal(val) {
    address = val;
    notifyListeners();
  }
}
