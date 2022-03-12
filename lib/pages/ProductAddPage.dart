import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key? key}) : super(key: key);

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product add"),
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                productAdd();
              },
              child: Text("Add Product"))
        ],
      ),
    );
  }

  void productAdd() {
    CollectionReference productCollection =
        FirebaseFirestore.instance.collection("products");
    productCollection.add({
      "name": "Blazer Jacquard Slim Lapel Blazer",
      "category": "0HEbRgrYZo9lYxvbh3lT",
      "currentPrice": "3548",
      "previousPrice": "4000",
      "description":
          "If you wear this turndown collar long sleeve blazer, you will be more handsome, charming and stand out in the crowd. Wearing this turndown collar long sleeve suit coat, you are more handsome, temperament and can successfully attract the attention of others. When you wear this turndown collar blazer,",
      "images": [
        "https://static-01.daraz.com.bd/p/ccde3ac06600956f1f4b8dbeb99c83f7.jpg"
      ]
    }).then((value) => print("product add successs")).catchError((onError)=>print(onError));
  }
}
