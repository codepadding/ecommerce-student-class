import 'package:flutter/material.dart';
import 'package:news/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    getTotalPrice() {
      double total = 0;
      for (Cart cart in context.watch<CartProvider>().carts) {
        total = total + (cart.currentPrice * cart.quantity);
      }

      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          context.read<CartProvider>().placeOrder(context);
        },
        child: Container(
          height: kToolbarHeight + 10,
          width: double.infinity,
          color: context.watch<CartProvider>().carts.isNotEmpty
              ? Colors.brown
              : Colors.grey,
          child: Center(
            child: context.watch<CartProvider>().loading
                ? CircularProgressIndicator(color: Colors.white,)
                : Text(
                    "Pay Now ${getTotalPrice()} tk",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total Item ${context.watch<CartProvider>().carts.length}",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Text(
            "Total Price : ${Provider.of<CartProvider>(context, listen: false).getTotal()} tk",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 20),
          ),
          Text("discount 0 tk",
              textAlign: TextAlign.right, style: TextStyle(fontSize: 20)),
          Divider(
            color: Colors.brown,
          ),
          Text(
            "Total Payable : ${Provider.of<CartProvider>(context, listen: false).getTotal()} tk",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}
