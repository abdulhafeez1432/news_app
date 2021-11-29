import 'package:flutter/material.dart';
import 'package:news_app/Screens/DataValidation/components/body.dart';

class DataValidationScreen extends StatelessWidget {
  final int userId;


  DataValidationScreen({required this.userId,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Body(userId: userId)),
    );
  }
}
