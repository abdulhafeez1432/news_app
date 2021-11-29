import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/Screens/Login/login_screen.dart';
import 'package:news_app/Screens/Signup/signup_screen.dart';
import 'package:news_app/Screens/Welcome/components/background.dart';
import 'package:news_app/components/rounded_button.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/help.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void toLogin(context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginScreen()));
    }
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
  return MaterialApp(
    home: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/mandate.jpeg"),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.55),


          ElevatedButton(onPressed: () { toLogin(context);  },
            child:  Text(
              'LOGIN',
              style: TextStyle(
                color: Color(0xff132137),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

          ),



        ],
      ),

      ),

    );


  }
}
