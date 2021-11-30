import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/home.dart';
import 'package:news_app/Screens/Login/login_screen.dart';
import 'package:news_app/Screens/OnBoard/onboarding_screen2.dart';
import 'package:news_app/constant/utilis.dart';

Future<void> main() async{
  //This should be used while in development mode, do NOT do this when you want to release to production, the aim of this answer is to make the development a bit easier for you, for production, you need to fix your certificate issue and use it properly, look at the other answers for this as it might be helpful for your case.
  HttpOverrides.global = MyHttpOverrides();
  final sharedPref = SharedPref();
  WidgetsFlutterBinding.ensureInitialized();
    var token = await sharedPref.getString('token');
    print(token);
    runApp(
        MaterialApp(
          home: token == null ? LoginScreen() : HomePage(),
        )
    );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
