import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/pages/ProductDetailsPage.dart';

class ProductItem extends StatefulWidget {
  ProductItem({Key? key, required this.product}) : super(key: key);

  var product;

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: widget.product,
              ),
            ));
        // Navigator.pushNamed(context, "news-details");
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          CachedNetworkImage(
            imageUrl: widget.product['images'][0],
            height: 150,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Image.network(
                "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg"),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "৳ ${widget.product['currentPrice']}",
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18
                ),
              )),
          Text(
            widget.product['name'],
            maxLines: 2,
            textAlign: TextAlign.left,
          )
        ])),
      ),
    );
  }
}
