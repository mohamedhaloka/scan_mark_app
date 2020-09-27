import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/cart.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

import '../../../db_helper.dart';

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  DbHelper dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 3),
                spreadRadius: 2,
                blurRadius: 4)
          ]),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailsView.id);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fresh Natural Own Graphs",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            Image.asset("assets/img/home/graps.png"),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            drawPriceDetails("Price", "1.68"),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            drawPriceDetails("Average Price", "2.08"),
            CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                drawButtonOptions(Icons.favorite, () {
                  print("love");
                }),
                drawButtonOptions(Icons.add, () async {
                  var cart = Cart({
                    'productName': "Product",
                    'photo': "https://j.top4top.io/p_1731mzz6s1.png",
                    'priceDetails': "30",
                    'averagePriceDetails': "28.5",
                  });
                  int id = await dbHelper.createCart(cart);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Add Product $id to Cart Successfuly")));
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  drawButtonOptions(icon, onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]),
        ),
        child: Icon(icon),
      ),
    );
  }

  drawPriceDetails(tittle, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        Text(
          "$price\$",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
      ],
    );
  }
}
