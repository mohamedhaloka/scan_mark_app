import 'package:flutter/cupertino.dart';
import 'package:scan_mark_app/models/products.dart';

class CartItem extends ChangeNotifier {
  List<Products> products = [];

  addProduct(Products product) {
    products.add(product);
  }

  inCart(Products productsList) {
    for (var product in products) {
      if (product.productName == productsList.productName) {
        return true;
      }
    }
    return false;
  }
}
