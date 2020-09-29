import 'package:dio/dio.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/progress_statue.dart';
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
                        _updateInfo(context);
                      },
                      buttonColor: kPrimaryColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _updateInfo(context) async {
    var userData = Provider.of<UserData>(context, listen: false);
    var progress = Provider.of<ProgressStatue>(context, listen: false);
    if (formKey.currentState.validate()) {
      progress.changeVal(true);
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
        kUserPhone: userData.phone,
        kUserAddress: userData.address
      });
      preferences.setString("username", userData.name);
      preferences.setString("userphone", userData.phone);
      preferences.setString("useraddress", userData.address);
      progress.changeVal(false);
      Navigator.pop(context);
      Alert.toast(context, "Your information has been successfully updated",
          position: ToastPosition.bottom, duration: ToastDuration.long);
    }
  }
}
