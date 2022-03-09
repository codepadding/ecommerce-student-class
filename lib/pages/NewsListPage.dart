import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constanceValue.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:news/pages/ProductDetailsPage.dart';

class NewsListPage extends StatefulWidget {
  NewsListPage({Key? key, required this.category}) : super(key: key);

  String category;

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  var latestNews = [];

  @override
  void initState() {
    // TODO: implement initState
    getCategoryNews(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.category} news list"),
          actions: [Icon(Icons.shopping_cart)],
        ),
        body: ListView.builder(
          itemCount: latestNews.length,
          // physics: NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          itemBuilder: (context, index) {
            var news = latestNews[index];

            String thumbnail = news['urlToImage'] != null
                ? news['urlToImage'].toString()
                : "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg";
            print(thumbnail);
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        news: news,
                      ),
                    ));
                // Navigator.pushNamed(context, "news-details");
              },
              child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    CachedNetworkImage(
                      imageUrl: thumbnail,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Image.network(
                          "https://news.aut.ac.nz/__data/assets/image/0006/92328/placeholder-image10.jpg"),
                    ),
                    Text(latestNews[index]['title'])
                  ])),
            );
          },
        ));
  }

  getCategoryNews(category) async {
    String api = getCateroryNews(category);
    var response = await http.get(Uri.parse(api));
    print('Response body: ${response.body}');
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    setState(() {
      latestNews = jsonResponse['articles'];
      ;
    });
  }
}
