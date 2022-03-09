import 'package:flutter/material.dart';
import 'package:news/widgets/HomeCategory.dart';
import 'package:news/widgets/HomeProductList.dart';
import 'package:news/widgets/HomeSlider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("E-commerce"),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "product-search");
                },
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
                            Expanded(child: Text("Search news")),
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
              )),
        ),
        drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "order"),
          // BottomNavigationBarItem(icon: Icon(Icons.home),label: "account"),
        ]),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // slider
            HomeSlider(),

            // category title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Categories"),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "category-list");
                      },
                      child: Text("See All")),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: HomeCategory(),
            ),
            // Product list
            HomeProductList()
          ],
        ));
  }
}
