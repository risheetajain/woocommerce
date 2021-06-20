import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/Products.dart';
import 'package:safira_woocommerce_app/ui/Recommendedforyou.dart';
import 'package:safira_woocommerce_app/ui/categories.dart';

import 'package:safira_woocommerce_app/ui/gertProductfromapi.dart';
import 'package:safira_woocommerce_app/ui/widgets/component.dart';

class Dashboard extends StatefulWidget {
  List<Product> product;
  List<ParentCategory> category;
  Dashboard({this.product, this.category});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Api_Services api_services = Api_Services();
  var response;
  int selected = 0;
  List<Product> product = [];

  getList() {
    product = widget.product;
    // categories = widget.category;
    setState(() {});
  }

  // BasePage basePage = BasePage();
//
  // int selected = 2;
  String title = "Dashboard";
  //String title = "";

  @override
  void initState() {
    super.initState();
    getList();
    print(product);
    product = widget.product;

    // basePage.title = "My Cart";
    // basePage.selected = 0;
  }

  var padding = new Padding(
    padding: EdgeInsets.all(5.0),
  );

  @override
  Widget build(BuildContext context) {
    print("ass+${widget.category}");
    // print(categories);
    print(product);
    return WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Carousal(MediaQuery.of(context).size.width * 0.51),
            Container(
              height: 40,
              child: UpperHeading("Get All Categories"),
            ),
            Container(
              child: CategoryPage(
                catergories: widget.category,
                product: widget.product,
              ),
              height: 100,
            ),
            Container(height: 33, child: UpperHeading("Recommended for you")),
            Container(
                height: 180,
                child: Recommendations(
                  product: product,
                )),
            Container(height: 35, child: UpperHeading("Various Products")),
            Container(
                height: 180,
                child: ProductsHorizontal(
                  product: product,
                ))
          ],
        )));
  }
}
