import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/provider/scan_qrcode.dart';
import 'package:scan_mark_app/views/favourite/view.dart';
import 'package:scan_mark_app/views/search/view.dart';
import 'package:scan_mark_app/views/setting/view.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<ScanQRCode>(context, listen: false).changeVal(false);
            TextEditingController textSuggestion = TextEditingController();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchView(
                      searchController: textSuggestion,
                    )));
          },
          child: Container(
            width: customWidth(context, 1),
            height: 50,
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text("Search..."), Icon(Icons.search)],
            ),
          ),
        )
      ],
    );
  }
}
