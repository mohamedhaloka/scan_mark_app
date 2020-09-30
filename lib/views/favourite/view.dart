import 'package:flutter/material.dart';
import 'package:scan_mark_app/views/favourite/favourite_list.dart';

import '../../const.dart';

class FavouriteView extends StatelessWidget {
  static String id = "Favourite View";
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: ExactAssetImage("assets/img/sign-in/bg.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Favourite item".toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
        ),
        body: Container(
          width: customWidth(context, 1),
          child: FavouriteList(),
        ),
      ),
    );
  }
}
