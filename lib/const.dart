import 'dart:ui';
import 'package:flutter/cupertino.dart';

import 'models/products.dart';

const kPrimaryColor = Color(0xff0E0E0E);

//User Collection
const String kUserCollection = "Users Collection";
const String kUserName = "user name";
const String kUserPhoto = "user photo";
const String kUserPhone = "user phone";
const String kUserEmail = "user email";
const String kUserPassword = "user pass";
const String kUserAddress = "user address";

//Post Collection
const String kProductCollection = "Products Collection";
const String kProductImage = "post image";
const String kProductTittle = "post name";
const String kProductDescription = "post description";
const String kProductPrice = "post price";
const String kProductAveragePrice = "post average price";
const String kProductADocumentID = "post document id";
const String kProductID = "post id";

//Market Collection
const String kMarketsCollection = "Super Markets List";
const String kMarketName = "market name";
const String kMarketImg = "market image";
const String kMarketPrice = "market price";
const String kMarketDistance = "distance";

//Cart Of User
const String kCartCollection = "Cart Of User";

//Cart Of User
const String kFavouriteCollection = "Favourite Of User";


//List Of Products
List<Products> productInfo = [];

customHeight(context, heiNum) {
  return MediaQuery.of(context).size.height * heiNum;
}

customWidth(context, wedNum) {
  return MediaQuery.of(context).size.width * wedNum;
}
