import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Products.dart' as p;
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/createOrder.dart';
import "package:provider/provider.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';

class AddtoCart {
  int addtoCart;
  AddtoCart({this.addtoCart});
}

class CartScreen extends BasePage {
  static String routeName = "/cart";
  List<p.Product> product;
  Customers details;

  CartScreen({this.product, this.details});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends BasePageState<CartScreen> {
  List<AddtoCart> addtoCart = [];
  List<Product> product;
  Product cart;

  int quantity = 1;
  int selected = 2;
  String title = "My Cart";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    List<p.Product> demoCarts = widget.product;
    List<p.Product> cart = [];
    int total = 0;
    //p.Product product;
    // BasePage basePage = BasePage();
    // basePage.title = "My Cart";
    // basePage.selected = 2;
    return Consumer<CartModel>(builder: (context, cartModel, child) {
      if (cartModel.cartProducts.length == 0) {
        return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.hourglass_empty,
            size: 30,
          ),
          Text(
            "Your Cart is empty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]));
      } else {
        for (var item in demoCarts) {
          for (var it in cartModel.cartProducts) {
            if (it.product_id == item.id) {
              cart.add(item);
              addtoCart.add(AddtoCart(addtoCart: 1));
            }
          }
        }
        return Scaffold(
            body: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                // int pr = cart[index].price as int;
                total = int.parse(cart[index].price);
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                      child: Dismissible(
                        key: Key(cart[index].id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            cart.removeAt(index);
                            cartModel.removeCartProduct(cart[index].id);
                          });
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              SvgPicture.asset(
                                "assets/Trash.svg",
                              ),
                            ],
                          ),
                        ),
                        child: GestureDetector(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 77,
                                child: AspectRatio(
                                  aspectRatio: 0.88,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Image.network(
                                        cart[index].images[0].src),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.04),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 10),
                                  Text.rich(
                                    TextSpan(
                                      text: "\$${cart[index].price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFF7643)),
                                      children: [
                                        TextSpan(
                                            text: " x2",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  new IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addtoCart[index].addtoCart =
                                            addtoCart[index].addtoCart + 1;
                                        total = int.parse(cart[index].price) +
                                            total;
                                      });
                                      cartModel.updateQuantity(cart[index].id,
                                          addtoCart[index].addtoCart);
                                    },
                                    icon: new Icon(Icons.add,
                                        size: width * 0.05,
                                        color: Colors.blueAccent),
                                  ),
                                  Text(
                                    addtoCart[index].addtoCart == 0
                                        ? "null"
                                        : addtoCart[index].addtoCart.toString(),
                                    style: TextStyle(fontSize: 17),
                                    textAlign: TextAlign.center,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (addtoCart[index].addtoCart == null) {
                                        setState(() {
                                          cart.removeAt(index);
                                          cartModel.removeCartProduct(
                                              cart[index].id);
                                        });
                                      }

                                      setState(() {
                                        print(addtoCart[index]);
                                        addtoCart[index].addtoCart == 0
                                            ? null
                                            : addtoCart[index].addtoCart =
                                                addtoCart[index].addtoCart - 1;
                                      });
                                      cartModel.updateQuantity(cart[index].id,
                                          addtoCart[index].addtoCart);
                                    },
                                    icon: new Icon(Icons.remove,
                                        size: width * 0.05,
                                        color: Colors.blueAccent),
                                  ),
                                ],
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                          product: cart[index],
                                        )));
                          },
                        ),
                      ),
                      onTap: () {}),
                );
              },
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 30,
              ),
              // height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 20,
                    color: Color(0xFFDADADA).withOpacity(0.15),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset("assets/receipt.svg"),
                        ),
                        Spacer(),
                        Text("Add voucher code"),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          // color: ,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: total.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: RaisedButton(
                            child: Text("Check Out"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateOrder(
                                            id: widget.details.id,
                                            cartProducts:
                                                cartModel.cartProducts,
                                            product: cart,
                                          )));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      }
    });
  }
}

class Body extends StatefulWidget {
  final List<p.Product> demoCarts;
  Customers details;
  Body({this.demoCarts});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<p.Product> demoCarts = [p.Product()];
  int addTocart = 0;
  @override
  Widget build(BuildContext context) {
    demoCarts = widget.demoCarts;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: 0 == 1
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(
                      Icons.hourglass_empty,
                      size: 30,
                    ),
                    Text(
                      "Your Cart is empty",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]))
            : ListView.builder(
                itemCount: demoCarts.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                      child: Dismissible(
                        key: Key(demoCarts[index].id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            demoCarts.removeAt(index);
                          });
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              // SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(
                          cart: demoCarts[index],
                          product: demoCarts,
                        ),
                      ),
                      onTap: () {}),
                ),
              ));
  }
}

class CartCard extends StatefulWidget {
  const CartCard({
    Key key,
    @required this.product,
    @required this.cart,
  }) : super(key: key);
  final List<p.Product> product;
  final p.Product cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int addtoCart = 1;
  Widget addtoCartWi() {
    var width = MediaQuery.of(context).size.width;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
          width: width * 0.16,
          child: new RaisedButton(
            onPressed: () => setState(() {
              addtoCart = addtoCart + 1;
            }),
            child: new Text(
              "+",
              style: new TextStyle(fontSize: width * 0.07),
            ),
            color: Colors.blueAccent,
            textColor: Colors.white,
          ),
        ),
        new Container(
          width: width * 0.1,
          child: new Text(
            "0",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        new Container(
          width: width * 0.16,
          child: new RaisedButton(
            onPressed: () {
              setState(() {
                if (addtoCart == 1) {
                } else {
                  addtoCart = addtoCart - 1;
                }
              });
            },
            child: new Text(
              "-",
              style: new TextStyle(fontSize: width * 0.07),
            ),
            color: Colors.blueAccent,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Row(
        children: [
          SizedBox(
            width: 77,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(widget.cart.images[0].src),
              ),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.name,
                style: TextStyle(color: Colors.black, fontSize: width * 0.05),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$${widget.cart.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                  children: [
                    TextSpan(
                        text: " x2",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            children: <Widget>[
              new IconButton(
                onPressed: () => setState(() {
                  addtoCart = addtoCart + 1;
                }),
                icon: new Icon(Icons.add,
                    size: width * 0.05, color: Colors.blueAccent),
              ),
              Text(
                addtoCart == 0 ? "null" : addtoCart.toString(),
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    addtoCart == 0 ? null : addtoCart = addtoCart - 1;
                  });
                },
                icon: new Icon(Icons.remove,
                    size: width * 0.05, color: Colors.blueAccent),
              ),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                      product: widget.cart,
                    )));
      },
    );
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Demo data for our cart

class CheckoutCard extends StatelessWidget {
  List<CartProducts> cartProducts = [];
  final int addTocart;
  CheckoutCard({
    this.cartProducts,
    this.addTocart,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  // color: ,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$337.15",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: RaisedButton(
                    child: Text("Check Out"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateOrder(
                                    cartProducts: cartProducts,
                                  )));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
