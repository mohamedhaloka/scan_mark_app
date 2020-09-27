import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

import '../../../const.dart';
import '../../../db_helper.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbHelper.allCarts(),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if (snapshot.hasData) {
            return LayoutBuilder(builder: (context, constrant) {
              if (snapshot.data.length == 0) {
                return Center(child: Text("No Data"));
              }
              return AnimationLimiter(
                child: ListView.builder(
                  itemBuilder: (_, index) =>
                      AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 575),
                    child: SlideAnimation(
                      verticalOffset: 150.0,
                      child: Container(
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
                            children: [
                              Text(
                                "${snapshot.data[index]['productName']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.network(
                                    "${snapshot.data[index]['photo']}",
                                    width: 100,
                                  ),
                                  CustomSizedBox(
                                      heiNum: 0.0, wedNum: 0.04),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        drawPriceDetails("Price",
                                            "${snapshot.data[index]['priceDetails']}"),

                                        drawPriceDetails("Average Price",
                                            "${snapshot.data[index]['averagePriceDetails']}"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              CustomSizedBox(heiNum: 0.034, wedNum: 0.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  drawButtonOptions(Icons.delete, () async {
                                    await dbHelper
                                        .deleteCart(snapshot.data[index]['id']);
                                    setState(() {});
                                  }),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemCount: snapshot.data.length,
                ),
              );
            });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
        CustomSizedBox(heiNum: 0.0, wedNum: 0.02),
        Text(
          "$price\$",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
      ],
    );
  }
}
