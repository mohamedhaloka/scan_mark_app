import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_mark_app/views/bottom_tab/home/products_list.dart';
import 'package:scan_mark_app/views/product_details/view.dart';

class SearchView extends SearchDelegate {
  @override
  String query;

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement appBarTheme
    return null;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {});
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final myList = query.isEmpty
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
}
