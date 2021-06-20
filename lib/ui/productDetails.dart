import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart' as p;
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';

class ProductDetail extends BasePage {
  ProductDetail({this.product});

  final p.Product product;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends BasePageState<ProductDetail> {
  int selected = 1;
  bool loa = true;
  String parsHtml(String as) {
    final htmls = parse(as);
    final String pars = parse(htmls.body.text).documentElement.text;
    print(pars);
    setState(() {
      loa = false;
    });
    return pars;
  }

  String shortDes;

  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
    print(widget.product.shortDescription);
    shortDes = parsHtml(widget.product.shortDescription);
    // basePage.title = "Checkout Page";
    // basePage.selected = 2;
  }

  @override
  Widget body(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = (screenSize.height) / 2;

    //var screenWidth = (screenSize.width) / 2;

    List<Product> cart = [];
    String title = widget.product.name;
    return Scaffold(
      body: ListView(
        children: [
          // container for the image of the product
          Container(
            height: screenHeight - 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    widget.product.images[0].src,

                    // width: width * 0.3,
                  )),
            ),
          ),
          // provides vertical space of 10 pxl
          SizedBox(height: 10),

          // container for the price & detail contents of the product
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                buildRowPriceRating(),
                SizedBox(height: 10),
                Text(widget.product.name, style: largeText),
                SizedBox(height: 10),
                Text(loa ? "" : shortDes, style: normalText),
                SizedBox(height: 10),
                Center(
                    child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  onPressed: () {
                    cart.add(widget.product);
                    Provider.of<CartModel>(context, listen: false)
                        .addCartProduct(widget.product.id, 1);
                    Fluttertoast.showToast(
                        msg:
                            "${widget.product.name} successfully added to cart",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  // color: product.color,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ADD TO CART",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      //  backgroundColor: product.color,
      title: Text(
        widget.product.name,
        style: TextStyle(fontSize: 22),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.add_shopping_cart,
            size: 30,
          ),
        )
      ],
    );
  }

  Row buildRowPriceRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Price: ₹${widget.product.price}", style: largeText),
        RatingBarIndicator(
          rating: 3.75,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amberAccent,
          ),
          itemCount: 5,
          itemSize: 25.0,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}

TextStyle smallText = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);

TextStyle normalText = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

TextStyle mediumText = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

TextStyle largeText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
