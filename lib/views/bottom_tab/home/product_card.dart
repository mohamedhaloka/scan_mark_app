import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/provider/order_done.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProductCard extends StatefulWidget {
  ProductCard({this.productInfo});
  Products productInfo;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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
              arguments: widget.productInfo);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.productInfo.productName}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            Image.network(
              "${widget.productInfo.productImage}",
              width: 60,
            ),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            drawPriceDetails("Price", "${widget.productInfo.productPrice}"),
            CustomSizedBox(heiNum: 0.01, wedNum: 0.0),
            drawPriceDetails(
                "Average Price", "${widget.productInfo.productAveragePrice}"),
            CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                drawButtonOptions(Icons.favorite, () async {
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
                    kProductDescription: widget.productInfo.productDescription,
                    kProductPrice: widget.productInfo.productPrice,
                    kProductID: widget.productInfo.productID,
                    kProductAveragePrice:
                        widget.productInfo.productAveragePrice,
                    kProductImage: widget.productInfo.productImage
                  }, loggedInUser.uid);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Fav ${widget.productInfo.productName} Successfully")));
                }),
                drawButtonOptions(Icons.add, () async {
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
                    kProductDescription: widget.productInfo.productDescription,
                    kProductPrice: widget.productInfo.productPrice,
                    kProductID: widget.productInfo.productID,
                    kProductAveragePrice:
                        widget.productInfo.productAveragePrice,
                    kProductImage: widget.productInfo.productImage
                  }, loggedInUser.uid);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Add ${widget.productInfo.productName} Successfully")));
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
        padding: EdgeInsets.all(2),
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
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
        Text(
          "$price EGP",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
      ],
    );
  }

  void addToCart(context, Products product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    cartItem.addProduct(product);
  }
}
