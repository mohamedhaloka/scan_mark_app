import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/bottom_navigation_index.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/views/about/view.dart';
import 'package:scan_mark_app/views/bottom_tab/view.dart';
import 'package:scan_mark_app/views/product_details/view.dart';
import 'package:scan_mark_app/views/search/view.dart';
import 'package:scan_mark_app/views/sign_in/view.dart';
import 'package:scan_mark_app/views/sign_up/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserData()),
        ChangeNotifierProvider(create: (context) => ChangeIndex())
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
          SignUpView.id: (context) => SignUpView(),
          ProductDetailsView.id: (context) => ProductDetailsView(),
          AboutView.id: (context) => AboutView(),
          SearchView.id: (context) => SearchView(),
        },
        initialRoute: SignInView.id,
      ),
    );
  }
}
