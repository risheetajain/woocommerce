import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/form_helper.dart';
import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/verifyAddress.dart';
import 'package:string_validator/string_validator.dart';

class CreateOrder extends BasePage {
  List<CartProducts> cartProducts;
  List<Product> product = [];
  final int id;
  CreateOrder({this.cartProducts, this.product, this.id});
  @override
  _CreateOrderState createState() => _CreateOrderState();
}

class _CreateOrderState extends BasePageState<CreateOrder> {
  final _formKey = GlobalKey<FormState>();
  Customers details;
  String first,
      last,
      city,
      state,
      postcode,
      apartmnt,
      flat,
      address,
      country,
      mobile,
      mail;
  int selected = 2;
  String title = "Create Order";
  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
    // basePage.title = "Checkout Page";
    // basePage.selected = 2;
  }

  @override
  Widget body(BuildContext context) {
    print(widget.product);
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("First Name"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Last Name"),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "First Name",
                        labelText: "First Name",
                        helperText: "Fist Name",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        first = value;
                        print(first);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid name";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        labelText: "Last Name",
                        helperText: "Last Name",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        print(value);
                        last = value;
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid last name";
                        }
                      },
                    ),
                  ),
                ],
              ),
              FormHelper.fieldLabel("Address"),
              TextFormField(
                initialValue: "",
                decoration: InputDecoration(
                  hintText: "Address",
                  labelText: "Address",
                  helperText: "Address",
                ),
                maxLines: 2,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  address = value;
                  print(address);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              FormHelper.fieldLabel("Apartmnt ,Flat"),
              TextFormField(
                initialValue: "",
                decoration: InputDecoration(
                  hintText: "Apartmnt ,Flat",
                  labelText: "Apartmnt ,Flat",
                  helperText: "Apartmnt ,Flat",
                ),
                maxLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  apartmnt = value;
                  return;
                  print(apartmnt);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Country"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("State"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Country",
                        labelText: "Country",
                        helperText: "Country",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        country = value;
                        print(country);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid  country";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "State",
                        labelText: "State",
                        helperText: "State",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        state = value;
                        print(state);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid name";
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("City"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("PostCode"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "City",
                        labelText: "City",
                        helperText: "City",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        city = value;
                        print(city);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid name";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "PostCode",
                        labelText: "PostCode",
                        helperText: "Post Code",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        postcode = value;
                        print(postcode);
                      },
                      validator: (value) {
                        bool valid = isNumeric(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid PostCode";
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Mobile No."),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Mail Id"),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Mobile",
                        labelText: "Mobile",
                        helperText: "Mobile",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        mobile = value;
                        print(first);
                      },
                      validator: (value) {
                        bool valid = isLength(value, 10);
                        bool vali = isNumeric(value);
                        if (valid && vali) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (vali) {
                          return "Enter valid no.";
                        } else if (valid) {
                          return "Enter 10 digit No.";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Mail Id",
                        labelText: "Mail Id",
                        helperText: "Mail Id",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String value) {
                        print(value);
                        mail = value;
                      },
                      validator: (value) {
                        bool valid = isEmail(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid Mail Id";
                        }
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: FormHelper.saveButton("Next", () {
                  if (_formKey.currentState.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyAddress(
                                  product: widget.product,
                                  id: widget.id,
                                  first: first,
                                  last: last,
                                  address: address,
                                  apartmnt: apartmnt,
                                  state: state,
                                  city: city,
                                  country: country,
                                  postcode: postcode,
                                  cartProducts: widget.cartProducts,
                                  mobile: mobile,
                                  mail: mail,
                                )));
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
