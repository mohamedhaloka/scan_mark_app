import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/views/setting/profile_photo.dart';
import 'package:scan_mark_app/widgets/custom_filled_button.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:scan_mark_app/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingView extends StatefulWidget {
  static String id = "Setting View";
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name, email, pass;
  @override
  Widget build(BuildContext context) {
    String photo = ModalRoute.of(context).settings.arguments;
    var userData = Provider.of<UserData>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: ExactAssetImage("assets/img/sign-in/bg.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
          title: Text(
            "setting".toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePhoto(
                  photo: photo,
                ),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            onChange: (val) {
                              setState(() {
                                userData.changeNameVal(val);
                                print(userData.name);
                              });
                            },
                            hint: "Name"),
                        CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                        CustomTextField(
                            onChange: (val) {
                              setState(() {
                                userData.changePhoneVal(val);
                                print(userData.phone);
                              });
                            },
                            hint: "Phone Number"),
                        CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                        CustomTextField(
                            onChange: (val) {
                              setState(() {
                                userData.changeAddressVal(val);
                                print(userData.address);
                              });
                            },
                            hint: "Address"),
                      ],
                    )),
                CustomSizedBox(heiNum: 0.04, wedNum: 0.0),
                FilledButton(
                    tittle: "update".toUpperCase(),
                    onPress: () {
                      _updateInfo();
                    },
                    buttonColor: kPrimaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateInfo() async {
    var userData = Provider.of<UserData>(context, listen: false);
    if (formKey.currentState.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String pass;
      setState(() {
        pass = preferences.getString("userpass");
      });
      Response response;
      Dio dio = new Dio();
      response = await dio
          .patch("https://scan-market.firebaseio.com/$pass.json", data: {
        kUserName: userData.name,
        kUserPhone:userData.phone,
        kUserAddress: userData.address
      });
      preferences.setString("username", userData.name);
      preferences.setString("userphone", userData.phone);
      preferences.setString("useraddress", userData.address);
      Navigator.pop(context);
    }
  }
}
