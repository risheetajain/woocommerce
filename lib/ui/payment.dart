import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Order.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/UpiPay.dart';
import 'package:safira_woocommerce_app/ui/checkoutPage.dart';
import 'package:safira_woocommerce_app/ui/homepage.dart';
import 'package:safira_woocommerce_app/ui/success.dart';
import 'package:safira_woocommerce_app/utils/RazorPaymentService.dart';
import 'package:upi_india/upi_india.dart';

class PaymentGateway extends BasePage {
  final String first,
      last,
      city,
      state,
      postcode,
      apartmnt,
      flat,
      mobile,
      mail,
      address,
      country;
  final int id;
  List<Product> product = [];
  List<CartProducts> cartProducts;
  PaymentGateway(
      {this.address,
      this.product,
      this.apartmnt,
      this.city,
      this.country,
      this.first,
      this.flat,
      this.id,
      this.last,
      this.mail,
      this.mobile,
      this.postcode,
      this.cartProducts,
      this.state});

  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends BasePageState<PaymentGateway> {
  Future<UpiResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;
  bool setPaid;
  String title, method;
  Api_Services api_services = Api_Services();
  RazorPaymentService razorPaymentService = RazorPaymentService();
  //BasePage basePage = BasePage();
  @override
  void dispose() {
    super.dispose();
    razorPaymentService.clears();
  }

  @override
  void initState() {
    // basePage.title = "My Cart";
    // basePage.selected = 2;
    razorPaymentService.initPaymentGateway(context);
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "8337976828@ybl",
      receiverName: 'Md Azharuddin',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  int selected = 2;
  // String title = "";
  @override
  Widget body(BuildContext context) {
    print("paym+${widget.product}");
    List<PayCard> _getPaymentCards() {
      List<PayCard> cards = [];

      cards.add(new PayCard(
          title: "Razor pay",
          description: "Pay bill using card",
          image: "assets/paycard.png",
          setPaid: true,
          onPressed: () async {
            razorPaymentService.getPayment(context);

            Orders orders = await api_services.createOrder(
                first: widget.first,
                setPaid: true,
                paymentMethod: "Razor pay",
                paymentMethodTitle: "Pay bill using card",
                last: widget.last,
                address: widget.address,
                apartmnt: widget.apartmnt,
                city: widget.city,
                country: widget.country,
                id: widget.id,
                postcode: widget.postcode,
                cartProducts: widget.cartProducts,
                state: widget.state,
                flat: widget.flat,
                mail: widget.mail,
                mobile: widget.mobile);
            // .then((value) => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             CheckoutWrapper(
            //               state: value,
            //               product: widget.product,
            //             ))));
          }));

      cards.add(new PayCard(
          title: "Upi pay",
          description: "Pay bill using UpiPay",
          image: "assets/paycard.png",
          setPaid: true,
          onPressed: () async {
            print("aahh");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UpiPay()));
            Orders orders = await api_services.createOrder(
                first: widget.first,
                setPaid: true,
                paymentMethod: "Upi pay",
                paymentMethodTitle: "Pay after recieving",
                last: widget.last,
                address: widget.address,
                apartmnt: widget.apartmnt,
                city: widget.city,
                country: widget.country,
                id: widget.id,
                postcode: widget.postcode,
                cartProducts: widget.cartProducts,
                state: widget.state,
                flat: widget.flat,
                mail: widget.mail,
                mobile: widget.mobile);

            setState(() {});
          }));
      cards.add(new PayCard(
          title: "Cash on Delivery",
          description: "Pay after recieving ",
          image: "assets/paycard.png",
          setPaid: false,
          onPressed: () async {
            Orders orders = await api_services
                .createOrder(
                    first: widget.first,
                    setPaid: false,
                    paymentMethod: "Cash on Delivery",
                    paymentMethodTitle: "Pay after recieving",
                    last: widget.last,
                    address: widget.address,
                    apartmnt: widget.apartmnt,
                    city: widget.city,
                    country: widget.country,
                    id: widget.id,
                    postcode: widget.postcode,
                    cartProducts: widget.cartProducts,
                    state: widget.state,
                    flat: widget.flat,
                    mail: widget.mail,
                    mobile: widget.mobile)
                .then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutWrapper(
                              state: value,
                              product: widget.product,
                            ))));
          }));
      return cards;
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _getPaymentCards().length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.white70,
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                      _getPaymentCards()[index].image),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getPaymentCards()[index].title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Pay bill using ${_getPaymentCards()[index].title}",
                                      //style: smallText,
                                    ),
                                  ],
                                ),
                                IconButton(
                                    icon: Icon(Icons.forward),
                                    onPressed:
                                        _getPaymentCards()[index].onPressed)
                              ],
                            )),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade200,
      title: Text(
        "PAYMENT",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () => {Navigator.pop(context)},
          child: Icon(
            CupertinoIcons.back,
            color: Colors.black38,
          )),
    );
  }
}

class PayCard {
  String title;
  String description;
  String image;
  Function onPressed;
  bool setPaid;

  PayCard(
      {this.title, this.description, this.image, this.onPressed, this.setPaid});
}
