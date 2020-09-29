import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/progress_statue.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/services/auth.dart';
import 'package:scan_mark_app/views/bottom_tab/view.dart';
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
  Future<UserDataModal> fetchUserData(id) async {
    final response =
        await http.get('https://scan-market.firebaseio.com/$id.json');
    print(response.headers);
    print(response.body);
    return UserDataModal.fromJson(json.decode(response.body));
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  String photo;
  String name;
  String address;
  String phone;

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
      ),
    );
  }

  _signIn(context) async {
    var userData = Provider.of<UserData>(context, listen: false);
    var progress = Provider.of<ProgressStatue>(context, listen: false);
    try {
      if (_formKey.currentState.validate()) {
        progress.changeVal(true);
        await Auth().signInWithEmailAndPassword(userData.email, userData.pass);
        fetchUserData(userData.pass).then((value) {
          setState(() {
            name = value.userName;
            photo = value.userPhoto;
            address = value.userAddress;
            phone = value.userPhone;
            print("USer Name: " + name);
            print("USer Photo: " + photo);
            print("USer Address: " + address);
            print("USer phone: " + phone);
          });
        });
        Timer(Duration(seconds: 2), () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("username", name);
          sharedPreferences.setString("userpass", userData.pass);
          sharedPreferences.setString("useremail", userData.email);
          sharedPreferences.setString("userphoto", photo);
          sharedPreferences.setString("userphone", phone);
          sharedPreferences.setString("useraddress", address);

          print("done");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BottomTabView()));

          sharedPreferences.setBool("seen", true);
          progress.changeVal(false);
        });
      }
    } catch (e) {
      progress.changeVal(true);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      progress.changeVal(false);
    }
    progress.changeVal(false);
  }
}
