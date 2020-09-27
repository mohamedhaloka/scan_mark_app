import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';

class AboutView extends StatelessWidget {
  static String id = "About View";
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
            child: SingleChildScrollView(
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
