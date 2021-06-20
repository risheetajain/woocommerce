import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:safira_woocommerce_app/ui/deleteAccount.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';

import 'package:safira_woocommerce_app/ui/Welcome.dart';
import 'package:safira_woocommerce_app/ui/homepage.dart';
import 'package:safira_woocommerce_app/ui/myaccounts.dart';
import 'package:safira_woocommerce_app/ui/notificationPage.dart';
import 'package:safira_woocommerce_app/ui/orderPage.dart';
import 'package:safira_woocommerce_app/ui/success.dart';
import 'package:safira_woocommerce_app/utils/notification.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';
import 'package:safira_woocommerce_app/utils/sharedpreferences.dart';

class Body extends StatefulWidget {
  Customers customer;
  Body({this.customer});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: Icons.person,
            press: () {
              print(widget.customer);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyAccount(customer: widget.customer)));
            },
          ),
          ProfileMenu(
              text: "Change Password",
              icon: Icons.lock,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Success(
                            text: "A link has been Sent to mail",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            })));
              }),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications,
            press: () {},
          ),
          ProfileMenu(
            text: " My Orders",
            icon: Icons.shopping_bag,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OrderPage()));
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icons.settings,
            press: () {},
          ),
          ProfileMenu(
            text: "About Us",
            icon: Icons.add_business_outlined,
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: Icons.help_center,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()));
            },
          ),
        ]));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.redAccent,
              size: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File _image;
  int selected = 2;
  String title = "";

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: _image == null
                ? AssetImage("assets/default.jpg")
                : FileImage(_image),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  getImage();
                },
                // label: Container(),
                child: Icon(
                  Icons.add_a_photo,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CompleteProfileScreen extends StatefulWidget {
  List<Product> product;
  Customers customer;
  CompleteProfileScreen({this.customer, this.product});

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedServices sharedServices = SharedServices();
    Api_Services api_services = Api_Services();
    return Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: Icons.person,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyAccount(
                                customer: widget.customer,
                              )));
                },
              ),
              ProfileMenu(
                  text: "Change Password",
                  icon: Icons.lock,
                  press: () {
                    Fluttertoast.showToast(
                        msg: "A link has been Sent to mail to change password",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }),
              ProfileMenu(
                text: "Notifications",
                icon: Icons.notifications,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                },
              ),
              ProfileMenu(
                text: " My Orders",
                icon: Icons.shopping_bag,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => OrderPage(
                                product: widget.product,
                                id: widget.customer.id,
                                customers: widget.customer,
                              )));
                },
              ),
              ProfileMenu(
                text: "Settings",
                icon: Icons.settings,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => DeleteAccount(
                                customers: widget.customer,
                              )));
                },
              ),
              ProfileMenu(
                text: "About Us",
                icon: Icons.add_business_outlined,
                press: () {},
              ),
              ProfileMenu(
                text: "Help Center",
                icon: Icons.help_center,
                press: () {},
              ),
              ProfileMenu(
                text: "Log Out",
                icon: Icons.logout,
                press: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                  sharedServices.logOut();
                  print(sharedServices.loginDetails());
                },
              ),
            ])));
  }
}
