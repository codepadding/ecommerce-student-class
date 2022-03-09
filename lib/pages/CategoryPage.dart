import 'package:flutter/material.dart';
import 'package:news/pages/NewsListPage.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> _categories = [
    "Cryptocurrency",
    "Sports",
    "Travel",
    "Technology",
    "Business",
    "Finance",
    "Entertainment",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",
    "Lifestyle",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Category Page")),
      body: GridView.builder(
        itemCount: _categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3,
            mainAxisExtent: 40,
            mainAxisSpacing: 3),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsListPage(
                    category: _categories[index],
                  ),
                ));
          },
          child: Container(
            color: Colors.blue,
            child: Center(
                child: Text(
              _categories[index],
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
