import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:scan_mark_app/provider/bottom_navigation_index.dart';
import '../../const.dart';

bottomAppBar(context, _scaffold, outputController) {
  var checkIndex = Provider.of<ChangeIndex>(context).initialIndex;
  return AppBar(
    elevation: 0.0,
    backgroundColor: kPrimaryColor,
    leading: GestureDetector(
      onTap: () => _scaffold.currentState.openDrawer(),
      child: Container(
        margin: EdgeInsets.all(10),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
            image: DecorationImage(
                image: NetworkImage(
                    "https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg"),
                fit: BoxFit.cover)),
      ),
    ),
    centerTitle: true,
    title: Image.asset(
      "assets/img/logo.png",
      fit: BoxFit.cover,
      width: 160,
      color: Colors.white,
    ),
    actions: [
      IconButton(
          icon: checkIndex == 0
              ? Image.asset(
                  "assets/img/home/scan.png",
                  color: Colors.white,
                )
              : Icon(Icons.check),
          onPressed: () {
            checkIndex == 0 ? _scan(outputController) : orderDone();
          })
    ],
  );
}

Future _scan(_outputController) async {
  String barcode = await scanner.scan();
  _outputController.text = barcode;
}

orderDone() {
  print("order done");
}
