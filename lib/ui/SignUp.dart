import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/constant.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';

import 'package:safira_woocommerce_app/ui/LoginPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:safira_woocommerce_app/ui/homepage.dart';
import 'package:safira_woocommerce_app/ui/widgets/mytextbutton.dart';
import 'package:string_validator/string_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Api_Services apiServices = Api_Services();
  var response = "hh";
  bool done = false;
  String firstName, username, lastName;
  String mail;
  TextEditingController t1, t2, t3, t4;
  final _formKey = GlobalKey<FormState>();
  //final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedServices sharedServices = SharedServices();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Container(),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Register",
              style: kHeadline,
            ),
            Text(
              "Create new account to get started.",
              style: kBodyText2,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: t1,
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                bool valid = EmailValidator.validate(text);
                if (valid) {
                  return null;
                } else {
                  return "Please Enter Valid Mail ";
                }
              },
              onChanged: (text) {
                mail = text;
                print(mail);
                setState(() {});
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  labelStyle: kBodyText,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  hintStyle: kBodyText,
                  hintText: "E-MAIL",
                  labelText: "Mail-Id"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: t2,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (text) {
                firstName = text;
                setState(() {});
                print(firstName);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                hintStyle: kBodyText,
                hintText: "FIRST NAME",
                labelText: "First Name",
                labelStyle: kBodyText,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (text) {
                lastName = text;
                print(lastName);
                setState(() {});
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  hintStyle: kBodyText,
                  labelStyle: kBodyText,
                  hintText: "LAST NAME",
                  labelText: "Last Name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: t4,
              keyboardType: TextInputType.text,
              onChanged: (text) {
                username = text;
                print(username);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  hintText: "USERNAME",
                  labelStyle: kBodyText,
                  labelText: "Username"),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: kBodyText,
                ),
                GestureDetector(
                    child: Text(
                      "Sign In",
                      style: kBodyText.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    })
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyTextButton(
              buttonName: 'Register',
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  var msg = await apiServices.createCustomers(
                      email: mail,
                      firstName: firstName,
                      lastName: lastName,
                      username: username);

                  Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  if (msg == "Signup successful") {
                    Customers customer =
                        await apiServices.getCustomersByMail(mail);
                    sharedServices.setLoginDetails(customer);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => BasePage(
                                  title: "Safira App",
                                  customer: customer,
                                )));
                    print(customer);
                  }
                }
              },
              bgColor: Colors.black87,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
    //
    // This trailing comma makes auto-formatting nicer fos.
  }
}
