import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scan_mark_app/views/bottom_tab/view.dart';

class SplashView extends StatefulWidget {
  static String id = "Splash View";

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomTabView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: ExactAssetImage("assets/img/splash/bg.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(
            "assets/img/splash/splash-logo.png",
            width: 220,
          ),
        ),
      ),
    );
  }
}
