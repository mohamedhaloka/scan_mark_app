import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/views/product_details/super_markets_list.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[500].withOpacity(0.4),
                offset: Offset(2, 3),
                blurRadius: 2,
                spreadRadius: 4)
          ]),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(22),
            child: Column(
              children: [
                Text(
                  "Fresh Natural Own Graphs",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/img/home/graps.png",
                      width: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        drawPriceDetails("Best Price", "1.68"),
                        CustomSizedBox(heiNum: 0.022, wedNum: 0.0),
                        drawPriceDetails("Average Price", "2.08"),
                      ],
                    )
                  ],
                ),
                CustomSizedBox(heiNum: 0.034, wedNum: 0.0),
                Row(
                  children: [
                    drawButtonOptions(Icons.favorite, () {
                      print("love");
                    }),
                    CustomSizedBox(heiNum: 0.0, wedNum: 0.05),
                    drawButtonOptions(Icons.add, () {
                      print("add");
                    }),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Stack(
            children: [
              Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.55),
              ),
              Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.12),
                color: Color(0xffEFF1F7),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: customWidth(context, 0.91),
                  height: customHeight(context, 0.55),
                  child: SuperMarketsList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  drawPriceDetails(tittle, price) {
    return Container(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tittle,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Text(
            "$price\$",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ],
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
}