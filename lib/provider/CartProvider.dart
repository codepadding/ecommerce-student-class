import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class CartProvider extends ChangeNotifier {
  List<Cart> carts = [];

  bool loading = false;

  addToCart(var product) {
    String productName = product['name'];
    String productImage = product['images'][0];
    String productId = product['id'];
    double oldPrice = double.parse(product['previousPrice']);
    double currentPrice = double.parse(product['currentPrice']);

    print("productId");
    print(productId);

    int index = carts.indexWhere((Cart element) => element.id == productId);

    if (index < 0) {
      carts.add(Cart(
          productName, oldPrice, currentPrice, 1, productId, productImage));
    } else {
      Fluttertoast.showToast(
          msg: "Already added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();

    print(carts.length);
  }

  updateQuantity(int index, String type) {
    Cart cart = carts[index];
    if (type == "add") {
      int newQuantity = cart.quantity + 1;
      Cart newCart = Cart(cart.productName, cart.oldPrice, cart.currentPrice,
          newQuantity, cart.id, cart.productImage);
      carts[index] = newCart;
    } else {
      int newQuantity = cart.quantity - 1;
      if (newQuantity == 0) {
        carts.removeAt(index);
      } else {
        Cart newCart = Cart(cart.productName, cart.oldPrice, cart.currentPrice,
            newQuantity, cart.id, cart.productImage);
        carts[index] = newCart;
      }
    }
    notifyListeners();
  }

  getTotal() {
    double total = 0;
    for (Cart element in carts) {
      total = total + element.currentPrice * element.quantity;
    }
    return total;
  }

  void placeOrder(context) {
    loading = true;
    notifyListeners();
    CollectionReference orderCollection =
        FirebaseFirestore.instance.collection("orders");
    orderCollection.add({
      "id": Uuid().v4(),
      "orderId": "BCN${Random().nextInt(100)}",
      "userId": "0HEbRgrYZo9lYxvbh3lT",
      "carts": json.decode(cartToJson(carts)),
    }).then((value) {
      loading = false;

      Fluttertoast.showToast(
          msg: "Successfully place order",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      carts.clear();

      Navigator.of(context)
        ..pop()
        ..pop();
      notifyListeners();
    }).catchError((onError) {
      loading = false;
      notifyListeners();
      print(onError);
    });
  }
}

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  String productName;
  String productImage;
  double oldPrice;
  double currentPrice;
  int quantity;
  String id;

  Cart(this.productName, this.oldPrice, this.currentPrice, this.quantity,
      this.id, this.productImage);

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      json["productName"],
      json["oldPrice"],
      json["currentPrice"],
      json["quantity"],
      json["id"],
      json["productImage"]);

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "oldPrice": oldPrice,
        "currentPrice": currentPrice,
        "quantity": quantity,
        "id": id,
        "productImage": productImage,
      };
}
