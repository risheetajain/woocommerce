import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart' as p;
import 'package:safira_woocommerce_app/ui/BasePage.dart';

import 'package:safira_woocommerce_app/ui/gertProductfromapi.dart';
import 'package:safira_woocommerce_app/ui/grocery.dart';
import 'package:safira_woocommerce_app/ui/vegetable.dart';

class CategoryPage extends BasePage {
  final catergories;
  final product;
  CategoryPage({this.catergories, this.product});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends BasePageState<CategoryPage> {
  /** */
  // Api_Services api_services = Api_Services();
  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
    // basePage.title = "My Cart";
    // basePage.selected = 2;
  }

  int selected = 2;
  String title = "Categories";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<p.ParentCategory> catergories = widget.catergories;
    print(catergories.length);
    print("ww");
    print(widget.catergories);
    return categories.length == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(3),
            color: Colors.white,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 3),
              scrollDirection: Axis.vertical,
              itemCount: catergories.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                final category = catergories[i];
                final padding = (i == 0) ? 10.0 : 0.0;
                return new GestureDetector(
                  onTap: () {
                    if (i == 0) {
                      print(i);
                      print(widget.product);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Grocery(
                                    product: widget.product,
                                  )));
                    }
                    if (i == 1) {
                      print(i);
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Vegetable(
                                    product: widget.product,
                                  )));
                    }
                  },
                  child: new Container(
                    margin: new EdgeInsets.only(left: padding),
                    height: width * 0.2,
                    child: new Column(
                      children: <Widget>[
                        new Image.network(
                          category.image.src,
                          height: width * 0.18,
                        ),
                        new Text(
                          category.name,
                          style: new TextStyle(
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
