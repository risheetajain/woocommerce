import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';

import 'package:safira_woocommerce_app/ui/categories.dart';
import 'package:safira_woocommerce_app/ui/dashboard.dart';
import 'package:safira_woocommerce_app/ui/profile.dart';

class BasePage extends StatefulWidget {
  Customers customer;
  int selected;
  String title;
  BasePage({this.customer, this.title});
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  List<Product> response;
  Api_Services api_services = Api_Services();
  List<ParentCategory> categories = [];
  List<Widget> list;
  Future getList() async {
    categories = await api_services.getCategoryById(133);
    print(categories.length);
    response = await api_services.getProducts();
    print("as+$response");
  }

  int selected = 0;
  @override
  void initState() {
    super.initState();
    // selected = widget.selected;
    getList().then((value) {
      print(list);
      print(categories);
      print(response);
      list = [
        Dashboard(
          product: response,
        ),
        CategoryPage(
          catergories: categories,
          product: response,
        ),
        CartScreen(
          product: response,
          details: widget.customer,
        ),
        CompleteProfileScreen(
          customer: widget.customer,
          product: response,
        )
      ];
    });
  }

  Widget body(BuildContext context) {
    //String title = widget.title;

    List<Widget> list = [
      Dashboard(
        product: response,
        category: categories,
      ),
      CategoryPage(
        catergories: categories,
        product: response,
      ),
      CartScreen(
        product: response,
        details: widget.customer,
      ),
      CompleteProfileScreen(
        customer: widget.customer,
        product: response,
      )
    ];
    print(categories);
    print("aw+$response");
    return list[selected];
  }

  Customers customer;

  @override
  Widget build(BuildContext context) {
    String title = widget.title == null ? " " : widget.title;
    List<Widget> list = [
      Dashboard(
        product: response,
        category: categories,
      ),
      CategoryPage(
        catergories: categories,
        product: response,
      ),
      CartScreen(
        product: response,
      ),
      CompleteProfileScreen(
        customer: customer,
        product: response,
      )
    ];
    print(response);
    print("ll+$response");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(title),
      ),
      body: body(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: selected,
        iconSize: 30,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        onTap: (inx) {
          setState(() {
            selected = inx;
          });
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category_rounded,
              ),
              label: "Category"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: "My Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "My Account")
        ],
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
