import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {

  final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();

  // snapshot.data!.docs
  // DocumentSnapshot document
  // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  @override
  Widget build(BuildContext context) {



    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }


        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 3, mainAxisExtent: 40, mainAxisSpacing: 3),
          itemBuilder: (context, index) {

            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

            return Container(
              color: Colors.blue,
              child: Center(
                  child: Text(
                    data['name'],
                    style: TextStyle(color: Colors.white),
                  )),
            );
          }
        );

      },
    );




  }
}
