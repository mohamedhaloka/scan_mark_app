import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/const.dart';
import 'package:scan_mark_app/models/products.dart';
import 'package:scan_mark_app/provider/scan_qrcode.dart';
import 'package:scan_mark_app/views/bottom_tab/home/products_list.dart';
import 'package:scan_mark_app/views/product_details/view.dart';

class SearchView extends StatefulWidget {
  SearchView({this.searchController});
  TextEditingController searchController = new TextEditingController();
  static String id = "Search View";
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String filter;

  @override
  initState() {
    widget.searchController.addListener(() {
      setState(() {
        filter = widget.searchController.text;
      });
    });
  }

  @override
  void dispose() {
    widget.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              Visibility(
                child: IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.info,
                          text: "${widget.searchController.text}",
                          title: "Product ID");
                    }),
                visible: Provider.of<ScanQRCode>(context).scan ? true : false,
              )
            ],
            title: Text('Search'.toUpperCase(),
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new TextField(
                cursorColor: kPrimaryColor,
                controller: widget.searchController,
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: productInfo.length,
                itemBuilder: (context, index) {
                  // if filter is null or empty returns all data
                  return filter == null || filter == ""
                      ? ListTile(
                          title: Text(
                            '${productInfo[index].productName}',
                          ),
                          subtitle: Text('Id ${productInfo[index].productID}'),
                          leading: new CircleAvatar(
                            backgroundImage:
                                NetworkImage(productInfo[index].productImage),
                            backgroundColor: Colors.transparent,
                          ),
                          onTap: () => _onTapItem(context, productInfo[index]),
                        )
                      : '${productInfo[index].productName}'
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? ListTile(
                              title: Text(
                                '${productInfo[index].productName}',
                              ),
                              subtitle: Text('Id ${productInfo[index].productID}'),
                              leading: new CircleAvatar(
                                backgroundImage: NetworkImage(
                                    productInfo[index].productImage),
                                backgroundColor: Colors.transparent,
                              ),
                              onTap: () =>
                                  _onTapItem(context, productInfo[index]),
                            )
                          : new Container();
                },
              ),
            ),
          ],
        ));
  }

  void _onTapItem(BuildContext context, Products post) {
    Navigator.pushNamed(context, ProductDetailsView.id, arguments: post);
  }
}
