import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({Key? key, required this.news}) : super(key: key);

  var news;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: widget.news['urlToImage'],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Image.network(
                "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg"),
          ),
          Text(widget.news['title']),
          Text(widget.news['description']),
          Text(widget.news['content']),
        ],
      ),
    );
  }
}
