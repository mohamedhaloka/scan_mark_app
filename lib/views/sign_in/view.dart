import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/widgets/custom_filled_button.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:scan_mark_app/widgets/custom_text_field.dart';

class SignInView extends StatelessWidget {
  static String id = "Sign In View";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/img/sign-in/bg.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 62, right: 62, top: 180, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/logo.png"),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Text("Hello, Sign In Your Account.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                CustomSizedBox(heiNum: 0.08, wedNum: 0.0),
                CustomTextField(hint: "E-Mail",onChange: (val){},),
                CustomSizedBox(heiNum: 0.055, wedNum: 0.0),
                CustomTextField(hint: "Password",onChange: (val){},),
                CustomSizedBox(heiNum: 0.052, wedNum: 0.0),
                FilledButton(tittle: "Sign In", onPress: (){}, buttonColor: kPrimaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
