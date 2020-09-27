import 'package:flutter/material.dart';
import 'package:scan_mark_app/views/bottom_tab/cart/cart_list.dart';
import '../../../const.dart';


class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.2),
                color: kPrimaryColor,
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.8),
                child: CartList(),
              )),
        ],
      ),
    );
  }
}
