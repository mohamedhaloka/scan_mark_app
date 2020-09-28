import 'package:flutter/material.dart';
import 'package:scan_mark_app/services/auth.dart';
import 'package:scan_mark_app/views/about/view.dart';
import 'package:scan_mark_app/views/setting/view.dart';
import 'package:scan_mark_app/views/sign_in/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:shape_of_view/shape/diagonal.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const.dart';

class BottomDrawer extends StatelessWidget {
  BottomDrawer({@required this.name, @required this.photo});
  String name;
  String photo;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ShapeOfView(
              elevation: 4,
              height: 300,
              shape: DiagonalShape(
                  position: DiagonalPosition.Bottom,
                  direction: DiagonalDirection.Right,
                  angle: DiagonalAngle.deg(angle: 10)),
              child: Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 30),
                color: kPrimaryColor,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, SettingView.id,arguments: photo);
                      },
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimaryColor,
                                image: DecorationImage(
                                    image: NetworkImage(photo == null
                                        ? "https://firebasestorage.googleapis.com/v0/b/scan-market.appspot.com/o/Jx4ATDi52BNaGHuTehxW2zMgt4C2%2FUserProfille%2Fimage_picker2771216902201923755.jpg?alt=media&token=b31dce1d-6b03-475f-a16e-8f897aac2ae2"
                                        : photo),
                                    fit: BoxFit.cover)),
                          ),
                          CustomSizedBox(heiNum: 0.016, wedNum: 0.0),
                          Text(
                            "$name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          drawListTile("Home", "home", context, ""),
          drawListTile("Cart", "shopping-cart", context, ""),
          drawListTile("Favourite", "favourite", context, ""),
          Divider(),
          drawListTile("About", "information", context, AboutView.id),
          drawListTile("Log out", "exit", context, ""),
        ],
      ),
    );
  }

  drawListTile(tittle, imgSrc, context, routeName) {
    return ListTile(
      leading: Image.asset(
        "assets/img/home/drawer/" + imgSrc + ".png",
        width: 25,
        height: 25,
      ),
      title: Text(tittle),
      onTap: tittle == "Home" || tittle == "Cart"
          ? () {
              Navigator.pop(context);
            }
          : tittle == "Log out"
              ? () async {
                  Auth().signOut();
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool("seen", false);
                  sharedPreferences.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInView()));
                }
              : () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, routeName);
                },
    );
  }
}
