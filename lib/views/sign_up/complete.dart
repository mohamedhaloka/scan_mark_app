import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/provider/progress_statue.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/views/bottom_tab/view.dart';
import 'package:scan_mark_app/widgets/custom_filled_button.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:scan_mark_app/widgets/custom_text_field.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../const.dart';

class CompleteSignUp extends StatefulWidget {
  @override
  _CompleteSignUpState createState() => _CompleteSignUpState();
}

class _CompleteSignUpState extends State<CompleteSignUp> {
  bool loading = false;

  String imgURL =
      "https://thumbs.dreamstime.com/b/user-account-line-icon-outline-person-logo-illustration-linear-pictogram-isolated-white-90234649.jpg";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context, listen: false);

    return ModalProgressHUD(
      inAsyncCall: Provider.of<ProgressStatue>(context).progress,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: ExactAssetImage("assets/img/sign-in/bg.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 62, right: 62, top: 180, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/logo.png"),
                  CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                  Text(
                    "Customize Your Account, Enter Your Information Below.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  CustomSizedBox(heiNum: 0.08, wedNum: 0.0),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: "Phone Number",
                            onChange: (val) {
                              setState(() {
                                userData.changePhoneVal(val);
                                print(userData.phone);
                              });
                            },
                          ),
                          CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                          CustomTextField(
                            hint: "Address",
                            onChange: (val) {
                              setState(() {
                                userData.changeAddressVal(val);
                                print(userData.address);
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
                              tittle: "Complete",
                              onPress: () {
                                _complete(context);
                              },
                              buttonColor: kPrimaryColor)),
                  CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _complete(context) async {
    var userData = Provider.of<UserData>(context, listen: false);
    var progress = Provider.of<ProgressStatue>(context, listen: false);
    try {
      if (_formKey.currentState.validate()) {
        progress.changeVal(true);

        Response response;
        Dio dio = new Dio();
        response = await dio.patch(
            "https://scan-market.firebaseio.com/${userData.pass}.json",
            data: {
              kUserName: userData.name,
              kUserPassword: userData.pass,
              kUserPhone: userData.phone,
              kUserEmail: userData.email,
              kUserAddress: userData.address,
              kUserPhoto: imgURL,
            });
        print("done create account");
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.clear();
        sharedPreferences.setBool("seen", true);
        sharedPreferences.setString("username", userData.name);
        sharedPreferences.setString("userphone", userData.phone);
        sharedPreferences.setString("useraddress", userData.address);
        sharedPreferences.setString("userpass", userData.pass);
        sharedPreferences.setString("useremail", userData.email);
        sharedPreferences.setString("userphoto", imgURL);

        print(sharedPreferences.getKeys());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomTabView()));
        progress.changeVal(false);
      }
    } catch (e) {
      progress.changeVal(true);

      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      progress.changeVal(false);
    }
    progress.changeVal(false);
  }
}
