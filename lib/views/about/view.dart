import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:scan_mark_app/views/about/modal.dart';

class AboutView extends StatefulWidget {
  static String id = "About View";

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  String data;

  Future<AboutUsModal> getData() async {
    http.Response response =
        await http.get("https://scan-market.firebaseio.com/aboutus.json");

    var data = json.decode(response.body);

    return AboutUsModal.fromJson(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData().then((value) {
      setState(() {
        data = value.content;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text(
          "About US".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: customWidth(context, 1),
            height: 120,
            color: kPrimaryColor,
            child: Center(
              child: Image.asset(
                "assets/img/logo.png",
                color: Colors.white,
                width: 290,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(18),
            width: customWidth(context, 1),
            height: customHeight(context, 0.7),
            child: data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Text(
                      "$data",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
