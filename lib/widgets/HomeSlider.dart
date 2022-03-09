import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {



  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String,dynamic>> snapshot = await _fireStore.collection('Banner').get();
    if (mounted) {
      setState(() {
        var length = snapshot.docs.length;
        print("============firebase=========");
        print(length);
      });
    }
    return snapshot.docs;
  }



  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(),
                child: CachedNetworkImage(
                  imageUrl: "https://picsum.photos/500/300?random=$i",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Image.network(
                    "https://i.picsum.photos/id/488/500/300.jpg?hmac=_jn-VVAFzOVMPjZOF3LSaWMGDfSIfGwRiU34JOsVRPo",
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.network(
                      "https://i.picsum.photos/id/655/500/300.jpg?hmac=5wixiaFhsvZaGyT0yLTEoLGaCDGsiv9_HiTIf0no8I4",
                      fit: BoxFit.cover),
                ));
          },
        );
      }).toList(),
    );
  }
}
