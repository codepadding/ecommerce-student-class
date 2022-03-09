import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/constanceValue.dart';
import 'package:news/pages/ProductDetailsPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as Api;

class NewsSearch extends StatefulWidget {
  const NewsSearch({Key? key}) : super(key: key);

  @override
  _NewsSearchState createState() => _NewsSearchState();
}

class _NewsSearchState extends State<NewsSearch> {
  late TextEditingController _editingController;

  var searchNews = [];

  @override
  void initState() {
    // TODO: implement initState
    // _editingController = TextEditingController();
    // _editingController.addListener(() {
    //   print(_editingController.text);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          // backgroundColor: Colors.white,
          title: Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
                //  padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.search, color: Colors.grey),
                        Expanded(
                          child: TextField(
                            // textAlign: TextAlign.center,

                            decoration: InputDecoration.collapsed(
                              hintText: ' Search by name or address',
                            ),
                            onChanged: (value) {
                              print(value);
                              getSearchNews(value);
                            },
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.mic,
                            color: Colors.grey,
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ),
        body: ListView.builder(
          itemCount: searchNews.length,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var news = searchNews[index];

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
                    Text(searchNews[index]['title'])
                  ])),
            );
          },
        ));
  }

  getSearchNews(searchKey) async {
    var apiEndPoint = searchNewsApi(searchKey);

    var response = await Api.get(Uri.parse(apiEndPoint));
    print('Response body: ${response.body}');
    var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    var articles = jsonResponse['articles'];
    setState(() {
      searchNews = articles;
    });
  }
}
