import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';

Future<List> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  return quotesList;
}

List quotesList = ["tittle1", "tittle2"];

class SearchView extends StatelessWidget {
  static String id = "Search View";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Search".toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SearchBar(
          onSearch: search,
          hintText: "Type Product",
          placeHolder: Center(child: Text("Search Now!")),
          onItemFound: (quot, int index) {
            return ListTile(
              onTap: () {},
              title: Text("${quot[index]}"),
              subtitle: Text("${quot[index]}"),
            );
          },
        ),
      ),
    );
  }
}
