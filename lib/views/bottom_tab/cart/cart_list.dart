import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

import '../../../const.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.uid);
      }
    } catch (e) {
      print("error" + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Store().getCartOfUser(loggedInUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Products> productInfoInCart = [];
            for (var doc in snapshot.data.docs) {
              productInfoInCart.add(Products(
                productImage: doc.data()[kProductImage],
                productName: doc.data()[kProductTittle],
                productPrice: doc.data()[kProductPrice],
                productAveragePrice: doc.data()[kProductAveragePrice],
                productID: doc.data()[kProductID],
                productDescription: doc.data()[kProductDescription],
                productDocumentID: doc.id,
              ));
            }
            return LayoutBuilder(builder: (context, constrant) {
              if (productInfoInCart.length == 0) {
                return Center(child: Image.asset("assets/img/empty-cart.png"));
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
                        child: Column(
                          children: [
                            Text(
                              "${productInfoInCart[index].productName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.network(
                                  "${productInfoInCart[index].productImage}",
                                  width: 100,
                                ),
                                CustomSizedBox(heiNum: 0.0, wedNum: 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      drawPriceDetails("Price",
                                          "${productInfoInCart[index].productPrice}"),
                                      drawPriceDetails("Average Price",
                                          "${productInfoInCart[index].productAveragePrice}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            CustomSizedBox(heiNum: 0.034, wedNum: 0.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                drawButtonOptions(Icons.delete, () {
                                  Store().deleteCartOfUserInfo(loggedInUser.uid,
                                      productInfoInCart[index].productDocumentID);
                                  setState(() {});
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Delete Successfuly")));
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: productInfoInCart.length,
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
