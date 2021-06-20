import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/Welcome.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';

class DeleteAccount extends StatefulWidget {
  Customers customers;
  DeleteAccount({this.customers});

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  SharedServices sharedServices = SharedServices();
  Api_Services api_services = Api_Services();

  @override
  Widget build(BuildContext context) {
    print(widget.customers.id);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ListTile(
          title: Text("Delete Account"),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Safira App"),
                    content: Text("Are you sure to delete the account??"),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No")),
                      FlatButton(
                          onPressed: () async {
                            api_services.deleteAccount(75).then(
                              (value) {
                                sharedServices.logOut();
                                Fluttertoast.showToast(
                                    msg:
                                        "Account has been Successfully deleted",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()));
                              },
                            );
                          },
                          child: Text("Yes"))
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
