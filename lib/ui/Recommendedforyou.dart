import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';
import 'package:safira_woocommerce_app/ui/widgets/component.dart';
import 'package:provider/provider.dart';

class Recommendations extends StatefulWidget {
  final List<Product> product;
  Recommendations({this.product});

  @override
  _RecommendationsState createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  int selected = 1;
  String title = "";
  int addtoCart = 0;
  List<Product> product = [];
  getList() {
    product = widget.product;
  }

  @override
  void initState() {
    getList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("am+$product");
    if (product == null) {
      print(product);
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print(product);
      return ListView.builder(
          itemCount: product.length - 13,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int id) {
            var width = MediaQuery.of(context).size.width;
            return GestureDetector(
                child: Container(
                  width: width * 0.4,
                  // height: 500,
                  color: Colors.white,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          //width: width * 0.30,
                          height: width * 0.22,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  product[id].images[0].src,

                                  // width: width * 0.3,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          product[id].name,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: new TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        new Text(
                          "₹" + product[id].salePrice.toString(),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: new TextStyle(fontSize: 12),
                        ),
                        new RaisedButton(
                          onPressed: () {
                            setState(() {
                              addtoCart = 1;
                            });

                            Provider.of<CartModel>(context, listen: false)
                                .addCartProduct(product[id].id, 1);
                            Fluttertoast.showToast(
                                msg:
                                    "${product[id].name} successfully added to cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          padding: EdgeInsets.all(10),
                          child: new Text(
                            "Add To Cart",
                            style: TextStyle(fontSize: 15),
                          ),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(
                                product: product[id],
                              )));
                });
          });
    }
  }
}
//
