import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/categories.dart';
import 'package:safira_woocommerce_app/ui/dashboard.dart';
import 'package:safira_woocommerce_app/ui/profile.dart';

class MyHomePage extends BasePage {
  Customers customer;
  MyHomePage({this.customer});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BasePageState<MyHomePage> {
  SearchBar searchBar;
  int inx;
  //

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('My Home Page'),
      actions: [searchBar.getSearchAction(context)],
      leading: Container(),
    );
  }

  _MyHomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }
  CarouselController buttonCarouselController = CarouselController();
  Api_Services api_services = Api_Services();
  var response;
  int selected = 2;

  var padding = new Padding(
    padding: EdgeInsets.all(5.0),
  );
  List<ParentCategory> categories = [];
  getList() async {
    categories = await api_services.getCategoryById(133);

    response = await api_services.getProducts();

    //print(response);
  }

  //  int selected = 2;
  String title = "HomePage";

  @override
  void initState() {
    super.initState();
    getList();
  }

  // List<Widget> _list = [
  //   CompleteProfileScreen(),
  //   Dashboard(),
  //   CompleteProfileScreen(),
  //   Dashboard(),
  // ];
  //String title = "HomePage";
  @override
  Widget body(BuildContext context) {
    getList();
    Customers customer = widget.customer;
    List<Widget> list = [
      Dashboard(),
      CategoryPage(
        catergories: categories,
        product: response,
      ),
      CartScreen(
        product: response,
      ),
      CompleteProfileScreen(
        customer: widget.customer,
      )
    ];

    return list[selected];
  }
}
