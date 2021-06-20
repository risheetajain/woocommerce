import 'dart:convert';

import 'package:safira_woocommerce_app/Config.dart';
import 'package:safira_woocommerce_app/models/CartRequest.dart';

import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Order.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';

import 'package:safira_woocommerce_app/networks/Authorization.dart';
import 'package:safira_woocommerce_app/models/TokenResponse.dart';
import 'package:safira_woocommerce_app/models/wrongCredential.dart';

import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Api_Services {
  WooCommerceAPI api;

  Api_Services() {
    api = new WooCommerceAPI(
        url: Config.url,
        consumerKey: Config.key,
        consumerSecret: Config.secret);
  }

  Future<Customers> createCustomer(
      {String firstName,
      String lastName,
      String email,
      String username}) async {
    var response =
        await api.postAsync("${Config.urlfor}" "${Config.customerUrl}", {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "username": username
    });
    print(response);
    Customers customer = Customers.fromJson(response);

    return customer;
  }

  Future createCustomers(
      {String firstName,
      String lastName,
      String email,
      String username}) async {
    http.Response response = await http.post(
        "https://test6.codegenie.online/wp-json/wc/v3/customers?consumer_key=ck_79c3925d255df6280e0d8e8950f8b1ecab47a253&consumer_secret=cs_1665540e3aa2af6647bf34b5f119ed4d5388373f",
        body: {
          "email": email,
          "first_name": firstName,
          "last_name": lastName,
          "username": username
        });

    String msg;
    if (response.statusCode == 400) {
      WrongCredential wrongCredential =
          WrongCredential.fromJson(jsonDecode(response.body));
      print(wrongCredential.message);
      msg = wrongCredential.message;
      return msg;
    }
    if (response.statusCode == 201) {
      msg = "Signup successful";

      var customerDetails = Customers.fromJson(jsonDecode(response.body));
      print(customerDetails.email);
    } else {
      msg = "Please Check Your Internet Connection";
    }
    return msg;
  }

  Future getCustomers(int id) async {
    var url = "${Config.urlfor}" "${Config.customerUrl}/$id";
    var response = await api.getAsync(url);

    return response;
  }

  Future<Customers> getCustomersByMail(String mail) async {
    // var url="${Config.customerUrl}?email=$mail";
    // var url="${Config.customerUrl}?email=$mail";
    var url = "${Config.urlfor}" "customers?email=$mail";
    var response = await api.getAsync(url);

    Customers customer = Customers.fromJson(response[0]);
    return customer;
  }

  Future getUsernameByMail(String mail) async {
    // var url="${Config.customerUrl}?email=$mail";
    var url = "${Config.urlfor}" "customers?email=$mail";
    String username;
    var response = await api.getAsync(url);
    print(response);
    if (response.length == 0) {
      print("invalid");
      username = null;
    } else {
      print("valid");
      Customers customer = Customers.fromJson(response[0]);
      print(username);
      username = customer.username;
    }
    return username;
  }

  Future getToken(String username, String password) async {
    var url = "https://test6.codegenie.online/wp-json/jwt-auth/v1/token";
    var response = await http.post(
      url,
      body: {"username": username, "password": password},
    );
    TokenResponses data = TokenResponses.fromJson(jsonDecode(response.body));

    print(data.token);
    return data.token;
  }

  Future getTokenDetails(String username, String password) async {
    var url = "https://test6.codegenie.online/wp-json/jwt-auth/v1/token";
    var response = await http.post(
      url,
      body: {"username": username, "password": password},
    );
    TokenResponses data = TokenResponses.fromJson(jsonDecode(response.body));

    print(data.token);
    return data;
  }

  Future authenicateViaJWT(String username, String password) async {
    String token = "";
    var url = "https://test6.codegenie.online/wp-json/jwt-auth/v1/token";
    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "",
        "Accept": "",
        "Authorization": "Bearer $token"
      },
    );

    TokenResponses data = TokenResponses.fromJson(jsonDecode(response.body));
    print(data.userEmail);
    print(response.body);
  }

  Future retrieveUserDetails(String email) async {
    var auth =
        "Basic" + base64Encode(utf8.encode("${Config.key}:${Config.secret}"));
    var url = "${Config.url}" "${Config.emailurl}$email";
    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": auth
      },
    );

    print(response.body);
  }

  Future getProductsById(int id) async {
    var url = "${Config.urlfor}" "${Config.productUrl}/$id";
    var response = await api.getAsync(url);

    Product product = Product.fromJson(response);
    // print(product);
    return product;
  }

  Future<List<ParentCategory>> getCategory() async {
    var url = "${Config.urlfor}" "${Config.categoriesUrl}?per_page=500";
    var response = await api.getAsync(url);

    List<ParentCategory> categoryList = [];
    for (var item in response) {
      categoryList.add(ParentCategory.fromJson(item));
    }
    return categoryList;
  }

  Future<List<Product>> getProducts() async {
    var url = "${Config.urlfor}" "${Config.productUrl}?per_page=100";
    var response = await api.getAsync(url);
    print(response);
    List<Product> productList = [];
    for (var item in response) {
      productList.add(Product.fromJson(item));
    }
    return productList;
  }

  Future<List<Orders>> getOrders() async {
    var url = "${Config.urlfor}" "${Config.orderUrl}?per_page=100";
    var response = await api.getAsync(url);
    print(response);
    List<Orders> orderList = [];
    for (var item in response) {
      orderList.add(Orders.fromJson(item));
    }

    return orderList;
  }

  Future<List<ParentCategory>> getCategoryById(int id) async {
    var url = "${Config.urlfor}"
        "${Config.categoriesUrl}"
        "${Config.parentforCategory}$id";
    var response = await api.getAsync(url);
    print(response);
    List<ParentCategory> categoryList = [];
    for (var item in response) {
      categoryList.add(ParentCategory.fromJson(item));
    }
    return categoryList;
  }

  Future<List<Orders>> getOrdersById(int id) async {
    var url = "${Config.urlfor}" "${Config.orderUrl}/$id";
    print(url);
    var response = await api.getAsync(url);
    print(response);
    List<Orders> orderList = [];
    for (var item in response) {
      orderList.add(Orders.fromJson(item));
    }
    print(orderList);

    return orderList;
  }

  Future<List<Orders>> getOrdersByUserId(String id) async {
    var url = "${Config.urlfor}" "${Config.orderUrl}?customer=$id";
    print(url);
    var response = await api.getAsync(url);
    print(response);
    List<Orders> orderList = [];
    for (var item in response) {
      orderList.add(Orders.fromJson(item));
    }
    print(orderList);

    return orderList;
  }

  Future addToCart(int id) async {
    var url = "/?${Config.addtoCartUrl}" "=$id";
    var response = await api.getAsync(url);
    print(response);
    return response;
  }

  Future deleteAccount(int id) async {
    var url = "${Config.urlfor}" "${Config.customerUrl}/$id?force=true";
    print(url);
    var response = await api.deleteAsync(url);
    print(response);
  }

  Future updateCustomers(
      {String firstName,
      String lastName,
      String email,
      String username,
      int id}) async {
    var url = "${Config.urlfor}" "${Config.customerUrl}/$id";
    // print(url);
    var body = (jsonEncode({
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
    }));
    var response = await api.putAsync(url, jsonDecode(body));
    print(response);

    var customerDetails = Customers.fromJson(response);
    print(customerDetails.email);
  }

  Future<Orders> createOrder({
    String first,
    last,
    city,
    state,
    postcode,
    apartmnt,
    flat,
    mobile,
    mail,
    address,
    country,
    paymentMethod,
    paymentMethodTitle,
    bool setPaid,
    int id,
    List<CartProducts> cartProducts,
  }) async {
    // CreateOrderModel model = CreateOrderModel();
    var url = "${Config.urlfor}" "${Config.orderUrl}";
    print(address);
    var body = jsonEncode({
      "payment_method": paymentMethod,
      "payment_method_title": paymentMethodTitle,
      "customer_id": 1,
      "set_paid": setPaid,
      "billing": {
        "first_name": first,
        "last_name": last,
        "address_1": address,
        "address_2": "",
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": mail,
        "phone": mobile
      },
      "shipping": {
        "first_name": first,
        "last_name": last,
        "address_1": address,
        "address_2": "",
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country
      },
      "line_items": cartProducts
    });
    print(body);
    var response = await api.postAsync(url, jsonDecode(body));
    Orders order = Orders.fromJson(response);
    print(order);
    return order;
  }

  getProduct(List<CartProducts> cartProducts) async {
    int i = 0;
    Api_Services api_services = Api_Services();
    List<Product> products = [];

    while (i < cartProducts.length) {
      Product product =
          await api_services.getProductsById(cartProducts[i].product_id);
      i++;

      products.add(product);
    }

    return products;
  }
  // Future loginCustomer(String email, String password) async {
  //   var response = await api.getAsync(Config.categoriesUrl);
  //   LoginResponse login = LoginResponse();
  //   return;
  // }
  //
  // Future<List<Category>> getCategories() async {
  //   String parent = "?parent=133";
  //   var response = await api.getAsync(Config.categoriesUrl + parent);
  //   List<Category> categoryList = [];
  //   for (var item in response) {
  //     categoryList.add(Category.fromJson(item));
  //   }
  //   return categoryList;
  // }
  //
  // Future<List<Product>> getProduct(
  //     {String tagId,
  //       String labelName,
  //       String sortBy,
  //       String sortOrder,
  //       String strSearch,
  //       String tagName,
  //       pageNumbr,
  //       int pageSize,
  //       String categoryId}) async {
  //   String tag = tagId == null ? "" : "?tag=$tagId";
  //   var response = await api.getAsync(Config.productUrl + tag);
  //   List<Product> products = [];
  //   for (var item in response) {
  //     products.add(Product.fromJson(item));
  //   }
  //   return products;
  // }
  //
  // Future<OrderDetailsModel> getOrder(String orderId) async{
  //   var url=Config;
  //   String order= orderId==null?"":"/tag=$orderId";
  //   var response= await api.getAsync(Config.orderUrl+orderId,);
  //   OrderDetailsModel orders;
  //   for (var item in response){
  //     OrderDetailsModel.fromJson(item);
  //   }
  //   return orders;
  // }
  //

}
