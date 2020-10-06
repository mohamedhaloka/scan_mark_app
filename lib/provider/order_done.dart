import 'package:flutter/cupertino.dart';
import 'package:scan_mark_app/models/products.dart';

class CartItem extends ChangeNotifier {
  List<Products> products = [];

  addProduct(Products product) {
    products.add(product);
  }


  inCart(List<Products> product)
  {
    for(var product in products)
      {
        return true;
      }
  }

}