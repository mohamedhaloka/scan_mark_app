import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/models/cart.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.productInfo});
  Products productInfo;
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
          Navigator.pushNamed(context, ProductDetailsView.id,
              arguments: productInfo);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${productInfo.productName}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            Image.network("${productInfo.productImage}"),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            drawPriceDetails("Price", "${productInfo.productPrice}"),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            drawPriceDetails(
                "Average Price", "${productInfo.productAveragePrice}"),
            CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                drawButtonOptions(Icons.favorite, () {
                  print("love");
                }),
                drawButtonOptions(Icons.add, () {}),
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
