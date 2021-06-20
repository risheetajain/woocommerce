import 'package:flutter/cupertino.dart';

import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';

class CartModel extends ChangeNotifier {
  List<CartProducts> cartProducts = [];
  Api_Services api_services = Api_Services();

  addCartProduct(int id, int quantity) {
    bool alreadyExist = cartProducts.any((element) => element.product_id == id);
    CartProducts cartProduct = CartProducts(
      product_id: id,
      quantity: quantity,
    );
    print(alreadyExist);
    alreadyExist ? updateQuantity(id, quantity) : cartProducts.add(cartProduct);

    notifyListeners();
  }

  removeCartProduct(int id) {
    final cart = cartProducts.firstWhere((element) => element.product_id == id);
    cartProducts.remove(cart);
    notifyListeners();
  }

  updateQuantity(int id, int quantity) {
    print("up");
    CartProducts mm =
        cartProducts.firstWhere((element) => element.product_id == id);
    print(mm);
    final cart = cartProducts.firstWhere((element) => element.product_id == id);
    cart.quantity = quantity + cart.quantity;
    print(cart.quantity);
    // cartProducts.add(cart);
    notifyListeners();
  }

  clearCart() {
    cartProducts.clear();
    notifyListeners();
  }
}
