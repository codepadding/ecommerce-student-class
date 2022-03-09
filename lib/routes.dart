import 'package:flutter/cupertino.dart';
import 'package:news/pages/CartPage.dart';
import 'package:news/pages/CategoryPage.dart';
import 'package:news/pages/CheckoutPage.dart';
import 'package:news/pages/ComparePage.dart';
import 'package:news/pages/FavoritePage.dart';
import 'package:news/pages/FlashPage.dart';
import 'package:news/pages/HomePage.dart';
import 'package:news/pages/LoginPage.dart';
import 'package:news/pages/MorePage.dart';
import 'package:news/pages/NewsSearchpage.dart';
import 'package:news/pages/PrivacyPage.dart';
import 'package:news/pages/SignUpPage.dart';
import 'package:news/pages/SplashScreen.dart';
import 'package:news/pages/SupportPage.dart';

class Routes {
  static String SplashScreen = "SplashScreen";

  static String HomePage = "HomePage";
  static String ProductDetailsPage = "ProductDetailsPage";

  static String CartPage = "CartPage";
  static String FavoritePage = "FavoritePage";

  static String CheckoutPage = "CheckoutPage";
  static String OrderListHistoryPage = "OrderListHistoryPage";

  static String CategoryPage = "CategoryPage";
  static String NewsSearch = "NewsSearch";

  static String LoginPage = "LoginPage";
  static String SignUpPage = "SignUpPage";

  static String MorePage = "MorePage";
  static String PrivacyPage = "PrivacyPage";
  static String SupportPage = "SupportPage";

  static String ComparePage = "ComparePage";
  static String FlashPage = "FlashPage";
}

Map<String, WidgetBuilder> routes = {
  Routes.SplashScreen: (context) => const SplashScreen(),
  Routes.HomePage: (context) => const HomePage(),
  Routes.CategoryPage: (context) => const CategoryPage(),
  Routes.NewsSearch: (context) => NewsSearch(),
  Routes.CartPage: (context) => CartPage(),
  Routes.CheckoutPage: (context) => CheckoutPage(),
  Routes.FavoritePage: (context) => FavoritePage(),
  Routes.MorePage: (context) => MorePage(),
  Routes.LoginPage: (context) => LoginPage(),
  Routes.SignUpPage: (context) => SignUpPage(),
  Routes.ComparePage: (context) => ComparePage(),
  Routes.FlashPage: (context) => FlashPage(),
  Routes.SupportPage: (context) => SupportPage(),
  Routes.PrivacyPage: (context) => PrivacyPage(),
};
