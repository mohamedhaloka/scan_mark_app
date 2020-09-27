import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

class SuperMarketsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          width: customWidth(context, 1),
          height: customHeight(context, 0.14),
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey[300])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/img/home/graps.png",
                width: 90,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Awlad Ragab",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "Price",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11),
                            ),
                            CustomSizedBox(heiNum: 0.0, wedNum: 0.02),
                            Text(
                              "1.8\$",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: 4,
    );
  }
}
