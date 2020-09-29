import 'package:easy_alert/easy_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/bottom_navigation_index.dart';
import 'package:scan_mark_app/provider/progress_statue.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/views/about/view.dart';
import 'package:scan_mark_app/views/bottom_tab/view.dart';
import 'package:scan_mark_app/views/onboarding/view.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/views/search/view.dart';
import 'package:scan_mark_app/views/setting/view.dart';
import 'package:scan_mark_app/views/sign_in/view.dart';
import 'package:scan_mark_app/views/sign_up/view.dart';
import 'package:scan_mark_app/views/splash/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  bool seenOnBoarding = sharedPreferences.getBool("seenOnBoarding");
  String _screenOnBoarding;

  if (seenOnBoarding == false || seenOnBoarding == null) {
    _screenOnBoarding = OnBoarding.id;
  } else {
    _screenOnBoarding = SignInView.id;
  }
  bool seen = sharedPreferences.getBool("seen");
  String _screen;

  if (seen == false || seen == null) {
    _screen = _screenOnBoarding;
  } else {
    _screen = SplashView.id;
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(AlertProvider(
      child: MyApp(
        screen: _screen,
      ),
      config: AlertConfig(ok: "", cancel: ""),
    ));
  });
}

class MyApp extends StatelessWidget {
  MyApp({this.screen});

  String screen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => ChangeIndex()),
        ChangeNotifierProvider(create: (context) => ProgressStatue()),
      ],
      child: MaterialApp(
        title: 'Scan Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            platform: TargetPlatform.iOS,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: kPrimaryColor,
            fontFamily: "Cairo"),
        routes: {
          BottomTabView.id: (context) => BottomTabView(),
          SignInView.id: (context) => SignInView(),
          OnBoarding.id: (context) => OnBoarding(),
          SignUpView.id: (context) => SignUpView(),
          ProductDetailsView.id: (context) => ProductDetailsView(),
          AboutView.id: (context) => AboutView(),
          SearchView.id: (context) => SearchView(),
          SettingView.id: (context) => SettingView(),
          SplashView.id: (context) => SplashView(),
        },
        initialRoute: screen,
      ),
    );
  }
}
