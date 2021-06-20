import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';
import 'package:safira_woocommerce_app/ui/widgets/component.dart';
import 'package:provider/provider.dart';

class ProductsHorizontal extends StatefulWidget {
  final List<Product> product;
  ProductsHorizontal({this.product});

  @override
  _ProductsHorizontalState createState() => _ProductsHorizontalState();
}

class _ProductsHorizontalState extends State<ProductsHorizontal> {
  int selected = 1;
  String title = "";
  int addtoCart = 0;
  bool loa = false;
  List<Product> cart = [];
  List<Product> product = [];
  getList() {
    product = widget.product;
    setState(() {
      cart = product.sublist(9);
    });
  }

  @override
  void initState() {
    getList();
    cart = product.sublist(6);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("am+$product");
    if (product == []) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // loa ? cart = product.sublist(9) : null;
      return ListView.builder(
          itemCount: cart.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int id) {
            var width = MediaQuery.of(context).size.width;
            cart = product.sublist(9);

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
                          // width: width * 0.30,
                          height: width * 0.22,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  cart[id].images[0].src,

                                  // width: width * 0.3,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          cart[id].name,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: new TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        new Text(
                          "₹" + cart[id].salePrice.toString(),
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
                                .addCartProduct(cart[id].id, 1);
                            Fluttertoast.showToast(
                                msg:
                                    "${cart[id].name} successfully added to cart",
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
                                product: cart[id],
                              )));
                });
          });
    }
  }
}
//
