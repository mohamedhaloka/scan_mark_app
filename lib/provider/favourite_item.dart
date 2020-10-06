import 'package:flutter/cupertino.dart';
import 'package:scan_mark_app/models/products.dart';

class FavouriteItem with ChangeNotifier{

  List<Products> favouriteProduct = [];

  addFavouriteProduct(Products product) {
    favouriteProduct.add(product);
  }


  inFavourite(Products favouriteList)
  {
    for(var product in favouriteProduct)
      {
        if(product.productName == favouriteList.productName)
          {
            return true;
          }
      }
    return false;
  }
}