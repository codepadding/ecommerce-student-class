import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> carts = [];

  addToCart(var product, int quantity) {
    String productName = product['name'];
    // String productId = product['id'];
    double oldPrice = double.parse(product['previousPrice']);
    double currentPrice = double.parse(product['currentPrice']);
    carts.add(Cart(productName, oldPrice, currentPrice, quantity));
    notifyListeners();

    print(carts.length);
  }
}

class Cart {
  String productName;
  double oldPrice;
  double currentPrice;
  int quantity;
  // String id;

  Cart(this.productName, this.oldPrice, this.currentPrice, this.quantity);
}
