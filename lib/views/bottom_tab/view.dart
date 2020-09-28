import 'package:bottom_indicator_bar/bottom_indicator_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/provider/bottom_navigation_index.dart';
import 'package:scan_mark_app/views/bottom_tab/bottom_drawer.dart';
import 'package:scan_mark_app/views/search/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const.dart';
import 'cart/view.dart';
import 'package:qrscan/qrscan.dart' as scanner;
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

  String photo, name;
  SharedPreferences preferences;
  getUserData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("username") ?? "hhhhhhh";
      photo = preferences.getString("userphoto");
    });
  }

  List<Widget> pageView = [HomeView(), CartView()];

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  TextEditingController outputController;

  @override
  initState() {
    super.initState();
    this.outputController = new TextEditingController();
  }

  Future _scan(context) async {
    String barcode = await scanner.scan();
    outputController.text = barcode;
    print("The Output of QR Code is:" + outputController.text);
    Navigator.pushNamed(context, SearchView.id,
        arguments: outputController.text);
  }

  orderDone() {
    print("order done");
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
                    image: NetworkImage(photo == null
                        ? "https://firebasestorage.googleapis.com/v0/b/scan-market.appspot.com/o/Jx4ATDi52BNaGHuTehxW2zMgt4C2%2FUserProfille%2Fimage_picker2771216902201923755.jpg?alt=media&token=b31dce1d-6b03-475f-a16e-8f897aac2ae2"
                        : photo),
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
                checkIndex == 0 ? _scan(outputController) : orderDone();
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
