import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/CartProvider.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  var product;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.CartPage);
                  },
                  child: Stack(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 40,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red)),
                        child: Center(
                            child: Text(
                              "${context
                                  .watch<CartProvider>()
                                  .carts
                                  .length}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )),
                      )
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          context.read<CartProvider>().addToCart(widget.product);
        },
        child: Container(
          height: kToolbarHeight,
          color: checkCart(widget.product['id']) == true
              ? Colors.green
              : Colors.grey,
          child: Center(
            child: Text(
              checkCart(widget.product['id']) ? "Add To Cart" : "Already Added",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          CachedNetworkImage(
            imageUrl: widget.product['images'][0],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) =>
                Image.network(
                    "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg"),
          ),
          Text(
            widget.product['name'],
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "৳  ${widget.product['previousPrice']}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                    decoration: TextDecoration.lineThrough),
              ),
              Text(
                  getDiscount(widget.product['previousPrice'],
                      widget.product['currentPrice']),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.red[300],
                  ))
            ],
          ),
          Text(
            "৳ ${widget.product['currentPrice']}",
            style: TextStyle(
                color: Colors.brown, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(widget.product['description']),
        ],
      ),
    );
  }

  getDiscount(previousPrice, currentPrice) {
    double prePrice = double.parse(previousPrice.toString());
    double currPrice = double.parse(currentPrice.toString());

    double discountPercentage = ((prePrice - currPrice) / prePrice) * 100;

    return "$discountPercentage";
  }

  checkCart(String productId) {
    int index = context
        .watch<CartProvider>()
        .carts
        .indexWhere((Cart element) => element.id == productId);

    if (index < 0) {
      return true;
    }

    return false;
  }
}
