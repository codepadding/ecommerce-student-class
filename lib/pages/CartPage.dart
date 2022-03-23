import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart List"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          Cart cart = context.read<CartProvider>().carts[index];

          return Container(
              padding: EdgeInsets.all(5),
              // height: 120,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        height: 80,
                        imageUrl: cart.productImage,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Image.network(
                            "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg"),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              cart.productName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Row(
                              children: [
                                Text(
                                  "৳  ${cart.oldPrice}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[400],
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "৳ ${cart.currentPrice}",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${context
                                                .watch<CartProvider>()
                                                .carts[index].quantity}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(Icons.remove,
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
        itemCount: context.watch<CartProvider>().carts.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox();
        },
      ),
    );
  }
}
