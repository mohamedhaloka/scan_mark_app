import 'package:flutter/material.dart';
import 'package:scan_mark_app/views/product_details/product_details.dart';

import '../../const.dart';

class ProductDetailsView extends StatelessWidget {
  static String id = "Product Details View";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        backgroundColor: kPrimaryColor,
      ),
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
                height: customHeight(context, 0.88),
                child: ProductDetails(),
              )),
        ],
      ),
    );
  }
}
