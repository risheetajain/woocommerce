import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';
import 'package:safira_woocommerce_app/ui/widgets/component.dart';
import 'package:provider/provider.dart';

class Grocery extends BasePage {
  Grocery({this.product});

  List<Product> product;

  @override
  _GroceryState createState() => _GroceryState();
}

class _GroceryState extends BasePageState<Grocery> {
  int selected = 1;
  String title = "aa";
  int addtoCart = 0;
  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    List<Product> product = widget.product;

    return product == []
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int id) {
              var width = MediaQuery.of(context).size.width;

              return GestureDetector(
                  child: Container(
                    width: width * 0.5,
                    //height: width * 0.4,
                    color: Colors.white,
                    child: Card(
                        child: Column(
                      children: <Widget>[
                        new Stack(
                          children: <Widget>[
                            Container(
                              width: width * 0.30,
                              height: width * 0.20,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      product[id].images[0].src,

                                      // width: width * 0.3,
                                    )),
                              ),
                            ),
                            new Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: new BoxDecoration(
                                  border: new Border.all(
                                      color: Colors.lightGreen,
                                      width: width * 0.00625),
                                  color: Colors.lightGreen[100]),
                              child: new Text(
                                "50" + "% OFF",
                                style: new TextStyle(fontSize: width * 0.03),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          product[id].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: new TextStyle(fontSize: width * 0.045),
                        ),
                        Text(
                          "₹" + product[id].salePrice.toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.05),
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
                          child: new Text("Add To Cart"),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                        )
                      ],
                    )),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(
                                  product: product[id],
                                )));
                  });
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          );
  }
}
//
