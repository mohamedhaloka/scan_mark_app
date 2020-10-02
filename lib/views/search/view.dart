import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/provider/scan_qrcode.dart';
import 'package:scan_mark_app/views/bottom_tab/home/products_list.dart';
import 'package:scan_mark_app/views/product_details/view.dart';

class SearchView extends SearchDelegate {
  SearchView({this.productID});

  String productID;

  @override
  String query;

  @override
  Widget buildResults(BuildContext context) {
    List myList = query.isEmpty
        ? productInfo
        : productInfo.where((p) => p.productName.startsWith(query)).toList();
    return ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailsView.id,
                  arguments: productInfo[index]);
            },
            title: Text("${myList[index].productName}"),
            subtitle: Text("${myList[index].productID}"),
          );
        });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
      Visibility(
        child: IconButton(
            icon: Icon(Icons.priority_high),
            onPressed: () {
              showDialog(
                  context: context,
                  child: CupertinoAlertDialog(
                    title: Text("Product ID"),
                    content: Text("$productID"),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"))
                    ],
                  ));
            }),
        visible: Provider.of<ScanQRCode>(context).scan ? true : false,
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List myList = query.isEmpty
        ? productInfo
        : productInfo.where((p) => p.productID.startsWith('1')).toList();
    return ListView.builder(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          final Products products = myList[index];
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailsView.id,
                  arguments: productInfo[index]);
            },
            title: Text("${products.productName}"),
            subtitle: Text("${products.productID}"),
          );
        });
  }
}
