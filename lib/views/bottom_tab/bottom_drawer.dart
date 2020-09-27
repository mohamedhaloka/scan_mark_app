import 'package:flutter/material.dart';
import 'package:scan_mark_app/views/about/view.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:shape_of_view/shape/diagonal.dart';
import 'package:shape_of_view/shape_of_view.dart';

import '../../const.dart';

class BottomDrawer extends StatelessWidget {
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
                      onPressed: () {},
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
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://cdn.now.howstuffworks.com/media-content/0b7f4e9b-f59c-4024-9f06-b3dc12850ab7-1920-1080.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          CustomSizedBox(heiNum: 0.016, wedNum: 0.0),
                          Text(
                            "Mohamed Nasr",
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
      leading: Image.asset("assets/img/home/drawer/" + imgSrc + ".png",width: 30,height: 30,),
      title: Text(tittle),
      onTap: tittle == "Home" || tittle == "Cart"
          ? () {
              Navigator.pop(context);
            }
          : () {
              tittle == "Log out"
                  ? Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => routeName))
                  : Navigator.pop(context);
              Navigator.pushNamed(context, routeName);
            },
    );
  }
}
