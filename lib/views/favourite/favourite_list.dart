import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scan_mark_app/const.dart';

class FavouriteList extends StatefulWidget {
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
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
        stream: Store().getFavouriteOfUser(loggedInUser.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Products> productInfo = [];
            for (var doc in snapshot.data.docs) {
              productInfo.add(Products(
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
              if (productInfo.length == 0) {
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
                            child: GestureDetector(
                              onTap: (){
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "${productInfo[index].productName}",
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
                                        "${productInfo[index].productImage}",
                                        width: 100,
                                      ),
                                      CustomSizedBox(heiNum: 0.0, wedNum: 0.04),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            drawPriceDetails("Price",
                                                "${productInfo[index].productPrice}"),
                                            drawPriceDetails("Average Price",
                                                "${productInfo[index].productAveragePrice}"),
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
                                        Store().deleteFavouriteOfUserInfo(
                                            loggedInUser.uid,
                                            productInfo[index].productDocumentID);
                                        setState(() {

                                        });
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
                      ),
                  itemCount: productInfo.length,
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
