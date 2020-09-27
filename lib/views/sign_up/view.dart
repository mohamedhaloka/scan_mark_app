import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_mark_app/services/auth.dart';
import 'package:scan_mark_app/views/sign_in/view.dart';
import 'package:scan_mark_app/widgets/custom_filled_button.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:scan_mark_app/widgets/custom_text_field.dart';

import '../../const.dart';

class SignUpView extends StatefulWidget {
  static String id = "Sign Up View";

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String email, pass;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
                  "Create Account, Enter Your Information Below.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CustomSizedBox(heiNum: 0.08, wedNum: 0.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "Name",
                          onChange: (val) {
                            email = val;
                          },
                        ),
                        CustomSizedBox(heiNum: 0.055, wedNum: 0.0),
                        CustomTextField(
                          hint: "E-Mail",
                          onChange: (val) {
                            email = val;
                          },
                        ),
                        CustomSizedBox(heiNum: 0.055, wedNum: 0.0),
                        CustomTextField(
                          hint: "Password",
                          onChange: (val) {
                            pass = val;
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
                                  builder: (context) => SignInView()));
                        },
                        child: Text(
                          "Sign In",
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
    try {
      if (_formKey.currentState.validate()) {
        await Auth().signUpWithEmailAndPassword(email, pass);
        print("done create account");
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
