import 'package:flutter/cupertino.dart';

class ScanQRCode with ChangeNotifier {
  bool scan = false;

  changeVal(value) {
    scan = value;
    notifyListeners();
  }
}
