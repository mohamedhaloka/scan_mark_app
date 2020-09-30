import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/provider/scan_qrcode.dart';
import 'package:scan_mark_app/views/product_details/view.dart';

// Future<List<Products>> search(String search) async {
//   await Future.delayed(Duration(seconds: 2));
//   return ;
// }

class SearchView extends StatelessWidget {
  static String id = "Search View";
  @override
  Widget build(BuildContext context) {
    var productId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Search".toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Visibility(
              child: IconButton(
                icon: Icon(Icons.priority_high),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: CupertinoAlertDialog(
                        title: Text("Product ID"),
                        content: Text("$productId"),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"))
                        ],
                      ));
                },
                color: kPrimaryColor,
              ),
              visible: Provider.of<ScanQRCode>(context).scan ? true : false,
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Container());
  }
}
