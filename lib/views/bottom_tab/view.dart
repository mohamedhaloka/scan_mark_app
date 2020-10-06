import 'package:bottom_indicator_bar/bottom_indicator_bar.dart';
import 'package:easy_alert/easy_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/provider/bottom_navigation_index.dart';
import 'package:scan_mark_app/provider/order_done.dart';
import 'package:scan_mark_app/provider/scan_qrcode.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/views/bottom_tab/bottom_drawer.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:scan_mark_app/views/search/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const.dart';
import 'cart/view.dart';
import 'home/view.dart';

class BottomTabView extends StatefulWidget {
  static String id = "Bottom Tab View";

  @override
  _BottomTabViewState createState() => _BottomTabViewState();
}

class _BottomTabViewState extends State<BottomTabView> {
  final List<BottomIndicatorNavigationBarItem> items = [
    BottomIndicatorNavigationBarItem(icon: Icons.home),
    BottomIndicatorNavigationBarItem(icon: Icons.shopping_cart),
  ];

  String photo, name, address, phone;
  SharedPreferences preferences;
  getUserData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("username") ?? "No User";
      photo = preferences.getString("userphoto");
      address = preferences.getString("useraddress");
      phone = preferences.getString("userphone") ??
          "https://thumbs.dreamstime.com/b/user-account-line-icon-outline-person-logo-illustration-linear-pictogram-isolated-white-90234649.jpg";
    });
  }

  List<Widget> pageView = [HomeView(), CartView()];

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
    getCurrentUser();
  }

  User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.uid);
      }
    } catch (e) {
      print("error" + e);
    }
  }

  TextEditingController _outputController;

  Future _scan(context) async {
    String barcode = await scanner.scan();
    this._outputController.text = barcode;
    print("The Output" + _outputController.text);
    Provider.of<ScanQRCode>(context, listen: false).changeVal(true);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchView(
                  searchController: _outputController,
                )));
  }

  orderDone(
    context,
  ) async {
    var card = Provider.of<CartItem>(context, listen: false);
    String name, address;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("username");
      address = sharedPreferences.getString("useraddress");
    });
    Store().storeOrders(
        {kUserName: name, kUserAddress: address, 'Time Send': DateTime.now()},
        card.products);

    Alert.toast(context,
        "ٍYour order has been successfully sent, we will contact you within 24 hours",
        position: ToastPosition.bottom, duration: ToastDuration.long);
  }

  @override
  Widget build(BuildContext context) {
    var checkIndex = Provider.of<ChangeIndex>(context).initialIndex;

    getUserData();
    return Scaffold(
      key: _scaffold,
      drawer: BottomDrawer(
        name: name,
        photo: photo,
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
          onTap: () => _scaffold.currentState.openDrawer(),
          child: Container(
            margin: EdgeInsets.all(10),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
                image: DecorationImage(
                    image: photo == null
                        ? ExactAssetImage("assets/img/default-user.jpg")
                        : NetworkImage(photo),
                    fit: BoxFit.cover)),
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/img/logo.png",
          fit: BoxFit.cover,
          width: 160,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              icon: checkIndex == 0
                  ? Image.asset(
                      "assets/img/home/scan.png",
                      color: Colors.white,
                    )
                  : Icon(Icons.check),
              onPressed: () {
                checkIndex == 0 ? _scan(context) : orderDone(context);
              })
        ],
      ),
      bottomNavigationBar: BottomIndicatorBar(
        onTap: (index) {
          Provider.of<ChangeIndex>(context, listen: false).changeIndex(index);
          setState(() {});
        },
        items: items,
        activeColor: kPrimaryColor,
        inactiveColor: Colors.grey[500],
        currentIndex:
            Provider.of<ChangeIndex>(context, listen: false).initialIndex,
        indicatorColor: kPrimaryColor,
      ),
      body: pageView.elementAt(
          Provider.of<ChangeIndex>(context, listen: false).initialIndex),
    );
  }
}
