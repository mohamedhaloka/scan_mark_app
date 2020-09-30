import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/markets.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';

// ignore: must_be_immutable
class SuperMarketsList extends StatefulWidget {
  SuperMarketsList({this.id});
  String id;
  @override
  _SuperMarketsListState createState() => _SuperMarketsListState();
}

class _SuperMarketsListState extends State<SuperMarketsList> {
  bool loading = true;
  List<Markets> marketsInfo = [];
  getMarkets() async {
    await for (var snapshot in Store().getMarketsOfProudest(widget.id)) {
      var data = snapshot.docs;
      for (var doc in data) {
        marketsInfo.add(Markets(
          name: doc.data()[kMarketName],
          distance: doc.data()[kMarketDistance],
          marketImg: doc.data()[kMarketImg],
          marketPrice: doc.data()[kMarketPrice],
        ));
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarkets();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                width: customWidth(context, 1),
                height: customHeight(context, 0.14),
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey[300])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      "${marketsInfo[index].marketImg}",
                      width: 90,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${marketsInfo[index].name}",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11),
                                  ),
                                  CustomSizedBox(heiNum: 0.0, wedNum: 0.02),
                                  Text(
                                    "${marketsInfo[index].marketPrice}EGP",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${marketsInfo[index].distance}",
                                style: TextStyle(
                                    color: Colors.grey,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: marketsInfo.length,
          );
  }
}
