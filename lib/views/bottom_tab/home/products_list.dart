import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/views/bottom_tab/home/product_card.dart';

class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  List<Products> productInfo = [];
  bool loading = true;
  getProducts() async {
    await for (var snapshot in Store().getProducts()) {
      var data = snapshot.docs;
      for (var doc in data) {
        productInfo.add(Products(
          productImage: doc.data()[kProductImage],
          productName: doc.data()[kProductTittle],
          productPrice: doc.data()[kProductPrice],
          productAveragePrice: doc.data()[kProductAveragePrice],
          productID: doc.data()[kProductID],
          productDescription: doc.data()[kProductDescription],
          productDocumentID: doc.id,
        ));
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : AnimationLimiter(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: customHeight(context, 0.00072)),
              itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 575),
                child: SlideAnimation(
                  verticalOffset: 150.0,
                  child: ProductCard(
                    productInfo: productInfo[index],
                  ),
                ),
              ),
              itemCount: productInfo.length,
            ),
          );
  }
}
