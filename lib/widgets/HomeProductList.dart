import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news/pages/ProductDetailsPage.dart';
import 'package:news/widgets/ProductItem.dart';

class HomeProductList extends StatefulWidget {
  const HomeProductList({Key? key}) : super(key: key);

  @override
  _HomeProductListState createState() => _HomeProductListState();
}

class _HomeProductListState extends State<HomeProductList> {

  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').snapshots();


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }


        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 3, mainAxisExtent: 250, mainAxisSpacing: 3),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {


            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


            return ProductItem(product:data);
          },
        );

      },
    );



  }
}
