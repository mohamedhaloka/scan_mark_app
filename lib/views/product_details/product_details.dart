import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/provider/favourite_item.dart';
import 'package:scan_mark_app/provider/order_done.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/views/product_details/super_markets_list.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  ProductDetails({this.productInfo});
  Products productInfo;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

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
    var cartItem = Provider.of<CartItem>(context);
    var favouriteItem = Provider.of<FavouriteItem>(context);
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
                  "${widget.productInfo.productName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.network(
                      "${widget.productInfo.productImage}",
                      width: 70,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        drawPriceDetails(
                            "Best Price", "${widget.productInfo.productPrice}"),
                        CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                        drawPriceDetails("Average Price",
                            "${widget.productInfo.productAveragePrice}"),
                      ],
                    )
                  ],
                ),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Row(
                  children: [
                    drawButtonOptions(
                        favouriteItem.inFavourite(widget.productInfo)
                            ? Icons.favorite
                            : Icons.favorite_border, () async {
                      addInFavourite(context, widget.productInfo);
                      String name, email, phone, address;
                      SharedPreferences sharedpreferences =
                          await SharedPreferences.getInstance();
                      setState(() {
                        name = sharedpreferences.getString("username");
                        email = sharedpreferences.getString("useremail");
                        phone = sharedpreferences.getString("userphone");
                        address = sharedpreferences.getString("useraddress");
                      });
                      Store().storeUserInfo({
                        kUserName: name,
                        kUserEmail: email,
                        kUserPhone: phone,
                        kUserAddress: address,
                      }, loggedInUser.uid);
                      //Store Cart
                      Store().storeFavouriteOfUser({
                        kProductTittle: widget.productInfo.productName,
                        kProductDescription:
                            widget.productInfo.productDescription,
                        kProductPrice: widget.productInfo.productPrice,
                        kProductID: widget.productInfo.productID,
                        kProductADocumentID:
                            widget.productInfo.productDocumentID,
                        kProductAveragePrice:
                            widget.productInfo.productAveragePrice,
                        kProductImage: widget.productInfo.productImage
                      }, loggedInUser.uid);
                      //Store Order
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Add ${widget.productInfo.productName} Successfully")));
                    }),
                    CustomSizedBox(heiNum: 0.0, wedNum: 0.05),
                    drawButtonOptions(
                        cartItem.inCart(widget.productInfo)
                            ? Icons.add_circle
                            : Icons.add, () async {
                      addToCart(context, widget.productInfo);
                      String name, email, phone, address;
                      SharedPreferences sharedpreferences =
                          await SharedPreferences.getInstance();
                      setState(() {
                        name = sharedpreferences.getString("username");
                        email = sharedpreferences.getString("useremail");
                        phone = sharedpreferences.getString("userphone");
                        address = sharedpreferences.getString("useraddress");
                      });
                      Store().storeUserInfo({
                        kUserName: name,
                        kUserEmail: email,
                        kUserPhone: phone,
                        kUserAddress: address,
                      }, loggedInUser.uid);
                      //Store Cart
                      Store().storeCartOfUserInfo({
                        kProductTittle: widget.productInfo.productName,
                        kProductDescription:
                            widget.productInfo.productDescription,
                        kProductPrice: widget.productInfo.productPrice,
                        kProductID: widget.productInfo.productID,
                        kProductAveragePrice:
                            widget.productInfo.productAveragePrice,
                        kProductImage: widget.productInfo.productImage
                      }, loggedInUser.uid);
                      //Store Order
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Add ${widget.productInfo.productName} Successfully")));
                    }),
                  ],
                )
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.53),
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
                  height: customHeight(context, 0.52),
                  child: SuperMarketsList(
                    id: widget.productInfo.productDocumentID,
                  ),
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
            "$price EGP",
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

  void addToCart(context, Products product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    cartItem.addProduct(product);
  }

  addInFavourite(context, Products products) {
    FavouriteItem favouriteList =
        Provider.of<FavouriteItem>(context, listen: false);
    favouriteList.addFavouriteProduct(products);
  }
}
