import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:scan_mark_app/views/sign_in/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatelessWidget {
  static String id = "On Boarding View";

  final List<Introduction> list = [
    Introduction(
      title: 'Register',
      subTitle: 'Create your account now and view all products',
      imageUrl: 'assets/images/onboarding3.png',
    ),
    Introduction(
      title: 'Scan',
      subTitle: 'Scan product for more details',
      imageUrl: '',
    ),
    Introduction(
      title: 'Order',
      subTitle: 'Request your order and reach your door',
      imageUrl: '',
    ),
    Introduction(
      title: 'Finish',
      subTitle: 'Do not forget to rate us in Google Play',
      imageUrl: '',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool("seenOnBoarding", true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInView(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}
