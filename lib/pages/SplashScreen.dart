import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, Routes.HomePage));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.brown,
        child: Center(
          child: Text("E-commerce App",
              style: TextStyle(fontSize: 25, color: Colors.white)),
        ),
      ),
    );
  }
}
