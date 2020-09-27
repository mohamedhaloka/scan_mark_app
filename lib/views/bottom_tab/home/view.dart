import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/views/bottom_tab/home/products_list.dart';
import 'package:scan_mark_app/views/bottom_tab/home/search.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: Container(
                width: customWidth(context, 1),
                height: 120,
                color: kPrimaryColor,
                child: Search(),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.7),
                child: ProductsList(),
              )),
        ],
      ),
    );
  }
}
