import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:safira_woocommerce_app/constant.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/TokenResponse.dart';

import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';

import 'package:safira_woocommerce_app/ui/ForgotPassword.dart';

import 'package:safira_woocommerce_app/ui/SignUp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/ui/homepage.dart';
import 'package:safira_woocommerce_app/ui/widgets/mytextbutton.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username, password, mail;
  String error1, error2;
  bool showPassword = true;
  Customers customer;
  final _formKey = GlobalKey<FormState>();
  Api_Services api_services = Api_Services();
  SharedServices sharedServices = SharedServices();
  void toggle() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //  SingleChildScrollView(child:
        Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            //resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
              elevation: 0,
              // leading: IconButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },

              // ),
            ),
            body: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Welcome back.",
                        style: kHeadline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You've been missed!",
                        style: kBodyText2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onChanged: (text) {
                          mail = text;
                          print(mail);
                          setState(() {});
                        },
                        validator: (text) {
                          bool valid = EmailValidator.validate(text);
                          if (valid) {
                            return null;
                          } else {
                            return "Please Enter Valid Mail ";
                          }
                        },
                        decoration: InputDecoration(
                          suffix: Icon(Icons.person),
                          hintText: "Email id",
                          labelText: "Email",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: showPassword,
                        onChanged: (text) {
                          password = text;
                          print(password);
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.length <= 6) {
                            return "Password must be more than 10 letters";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Password",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            labelText: "Password",
                            suffix: GestureDetector(
                              child: showPassword
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined),
                              onTap: () {
                                toggle();
                              },
                            )),
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dont't have an account? ",
                            style: kBodyText,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Register',
                              style: kBodyText.copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24.0),
                      MyTextButton(
                          buttonName: 'Sign In',
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              //
                              username =
                                  await api_services.getUsernameByMail(mail);
                              print(username);
                              if (username == null) {
                                Fluttertoast.showToast(
                                    msg: "EMAIL IS NOT REGISTERED",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                var token = await api_services.getToken(
                                    username, password);

                                if (token == null) {
                                  Fluttertoast.showToast(
                                      msg: "WRONG CREDENTIAL",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Customers customer = await api_services
                                      .getCustomersByMail(mail);
                                  Fluttertoast.showToast(
                                      msg: "Login Successful",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  sharedServices.setLoginDetails(customer);

                                  Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => BasePage(
                                                //selected: 0,
                                                title: "Safira App",
                                                customer: customer,
                                              )));
                                }
                              }
                            }
                          },
                          bgColor: Colors.black87,
                          textColor: Colors.white),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: kBodyText.copyWith(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ])));
  }
}
