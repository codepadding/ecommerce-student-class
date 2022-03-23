import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> carts = [];

  addToCart(var product) {
    String productName = product['name'];
    String productImage = product['images'][0];
    String productId = product['id'];
    double oldPrice = double.parse(product['previousPrice']);
    double currentPrice = double.parse(product['currentPrice']);

    print("productId");
    print(productId);

    int index = carts.indexWhere((Cart element) => element.id == productId);

    if(index<0){
      carts.add(Cart(productName, oldPrice, currentPrice, 1, productId,productImage));
    }else{
      Fluttertoast.showToast(
          msg: "Already added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    notifyListeners();

    print(carts.length);
  }
}

class Cart {
  String productName;
  String productImage;
  double oldPrice;
  double currentPrice;
  int quantity;
  String id;

  Cart(this.productName, this.oldPrice, this.currentPrice, this.quantity,
      this.id,this.productImage);
}
