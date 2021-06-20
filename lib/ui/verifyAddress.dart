import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/form_helper.dart';
import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/payment.dart';

// ignore: must_be_immutable
class VerifyAddress extends BasePage {
  List<Product> product = [];
  final int id;
  final String first,
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

  List<CartProducts> cartProducts;

  VerifyAddress(
      {this.id,
      this.mobile,
      this.mail,
      this.address,
      this.product,
      this.apartmnt,
      this.city,
      this.country,
      this.first,
      this.flat,
      this.last,
      this.postcode,
      this.state,
      this.cartProducts});
  @override
  _VerifyAddressState createState() => _VerifyAddressState();
}

class _VerifyAddressState extends BasePageState<VerifyAddress> {
  int selected = 2;
  String title = "";
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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
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
                      child: FormHelper.fieldLabel("First Name"),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormHelper.fieldLabelValu(context, widget.first),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormHelper.fieldLabelValu(context, widget.last),
                      ),
                    ),
                  ],
                ),
                FormHelper.fieldLabel("Address"),
                FormHelper.fieldLabelValu(context, widget.address),
                FormHelper.fieldLabel("Apartmnt ,Flat"),
                FormHelper.fieldLabelValu(context, widget.apartmnt),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormHelper.fieldLabel("Country"),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormHelper.fieldLabel("State"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            FormHelper.fieldLabelValu(context, widget.country),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormHelper.fieldLabelValu(context, widget.state),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormHelper.fieldLabel("City"),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormHelper.fieldLabel("PostCode"),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FormHelper.fieldLabelValu(context, widget.city),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            FormHelper.fieldLabelValu(context, widget.postcode),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton("Next", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentGateway(
                                  first: widget.first,
                                  last: widget.last,
                                  cartProducts: widget.cartProducts,
                                  id: widget.id,
                                  city: widget.city,
                                  country: widget.country,
                                  postcode: widget.postcode,
                                  address: widget.address,
                                  apartmnt: widget.apartmnt,
                                  state: widget.state,
                                  flat: widget.flat,
                                  mail: "aswaaaapppppp@gmail.com",
                                  mobile: "",
                                  product: widget.product,
                                )));
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
