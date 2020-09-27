class Cart {
  String _productName;
  String _photo;
  String _priceDetails;
  String _averagePriceDetails;

  Cart(dynamic obj) {
    _productName = obj['productName'];
    _photo = obj['photo'];
    _priceDetails = obj['priceDetails'];
    _averagePriceDetails = obj['averagePriceDetails'];
  }

  Cart.fromMap(Map<String, dynamic> data) {
    _productName = data['productName'];
    _photo = data['photo'];
    _priceDetails = data['priceDetails'];
    _averagePriceDetails = data['averagePriceDetails'];
  }

  Map<String, dynamic> toMap() => {
        'productName': _productName,
        'photo': _photo,
        'priceDetails': _priceDetails,
        'averagePriceDetails': _averagePriceDetails
      };

  String get priceName => _productName;
  String get photo => _photo;
  String get priceDetails => _priceDetails;
  String get averagePriceDetails => _averagePriceDetails;
}
