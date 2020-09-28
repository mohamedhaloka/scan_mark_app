import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/services/auth.dart';
import 'package:scan_mark_app/views/sign_in/modal.dart';
import 'package:scan_mark_app/views/sign_up/view.dart';
import 'package:scan_mark_app/widgets/custom_filled_button.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:scan_mark_app/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInView extends StatefulWidget {
  static String id = "Sign In View";

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
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
                Text(
                  "Hello, Sign In Your Account.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CustomSizedBox(heiNum: 0.08, wedNum: 0.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "E-Mail",
                          onChange: (val) {
                            setState(() {
                              userData.changeEmailVal(val);
                            });
                          },
                        ),
                        CustomSizedBox(heiNum: 0.055, wedNum: 0.0),
                        CustomTextField(
                          hint: "Password",
                          onChange: (val) {
                            setState(() {
                              userData.changePassVal(val);
                            });
                          },
                        ),
                      ],
                    )),
                CustomSizedBox(heiNum: 0.052, wedNum: 0.0),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Builder(
                        builder: (context) => FilledButton(
                            tittle: "Sign In",
                            onPress: () {
                              _signIn(context);
                            },
                            buttonColor: kPrimaryColor)),
                CustomSizedBox(heiNum: 0.052, wedNum: 0.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    CustomSizedBox(heiNum: 0.0, wedNum: 0.02),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => SignUpView()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signIn(context) async {
    var userData = Provider.of<UserData>(context, listen: false);

    try {
      if (_formKey.currentState.validate()) {
        await Auth().signInWithEmailAndPassword(userData.email, userData.pass);
        print("done");
        setState(() {
          loading = true;
        });
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
    setState(() {
      loading = false;
    });
  }
}
