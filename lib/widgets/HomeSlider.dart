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


  final Stream<QuerySnapshot> _bannerStream = FirebaseFirestore.instance.collection('banner').snapshots();



  @override
  Widget build(BuildContext context) {



    return StreamBuilder<QuerySnapshot>(
      stream: _bannerStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }


        print("snapshot.data!.docs.toString()");
        print(snapshot.data!.docs.toString());
        return CarouselSlider(
          options: CarouselOptions(height: 200.0),
          items: snapshot.data!.docs.map((DocumentSnapshot document) {

            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            print("data['image']");
            print(data['image']);
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(),
                    child: CachedNetworkImage(
                      imageUrl: data['image'],
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
      },
    );




  }
}
