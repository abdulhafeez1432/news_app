import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/Pages/home.dart';
import 'package:news_app/Screens/AdFavorite/add_favorite.dart';
import 'package:news_app/Screens/DataValidation/data_validation_screen.dart';
import 'package:news_app/Screens/Login/login_screen.dart';
import 'package:news_app/Screens/DataValidation/components/background.dart';
import 'package:news_app/Screens/DataValidation/components/or_divider.dart';
import 'package:news_app/Screens/DataValidation/components/social_icon.dart';
import 'package:news_app/components/already_have_an_account_acheck.dart';
import 'package:news_app/components/rounded_button.dart';
import 'package:news_app/components/text_field_container.dart';
import 'package:news_app/constant/utilis.dart';
import 'package:news_app/constants.dart';
import 'package:http/http.dart' as http;



class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void toFavoritePage(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AddFavorite()));


  }


  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerCPassword = TextEditingController();
  final sharedPref = SharedPref();

  Future<void> Register() async {
    
    String BASE_URL = 'http://api.allnigerianewspapers.com.ng/api';
    final response = await http.post(
      Uri.parse('$BASE_URL/register/'),
      headers: Utils.configHeader(),
      body: jsonEncode(
        {
          "username": controllerUserName.text,
          "password": controllerPassword.text,
          "email": controllerEmail.text,
          "first_name": controllerFirstName.text,
          "last_name": controllerLastName.text,
        },
      ),
    );

    var datauser = json.decode(response.body.toString());
    print("This response is working fine ${response.statusCode}");
    if (response.statusCode == 200) {

      Fluttertoast.showToast(
        msg: "Registration Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      controllerFirstName.clear();
      controllerLastName.clear();
      controllerEmail.clear();
      controllerUserName.clear();
      controllerPassword.clear();
      controllerCPassword.clear();
      await sharedPref.setString('token', datauser['token']);
      toFavoritePage(context);

    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: "May be The User has Already Exits Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    else {
      Fluttertoast.showToast(
          msg: "Invalid data supplied",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        alignment: Alignment.center,
        width: double.infinity,
        height: size.height,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerFirstName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your FirstName',
                hintText: 'Enter Your FirstName',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.black45,
                ),
              ),
              autofocus: false,

            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerLastName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Lastname',
                hintText: 'Enter Your Lastname',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.black45,
                ),
              ),
              autofocus: false,

            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Email',
                hintText: 'Enter Your Email',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.black45,
                ),
              ),
              autofocus: false,

            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerUserName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Username',
                hintText: 'Enter Your Username',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.black45,
                ),
              ),
              autofocus: false,

            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Password',
                hintText: 'Enter Your Password',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.black45,
                ),
              ),
              autofocus: false,

            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerCPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Your Password',
                hintText: 'Confirm Your Password',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black45,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.black45,
                ),
              ),
              autofocus: false,

            ),
            SizedBox(height: size.height * 0.03),
            OrDivider(),
            SizedBox(
              height: 50,
              width: 300,
              child: FlatButton(
                color: Color(0xFF81C784),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                onPressed: () {

                    if (controllerFirstName.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "FullName is Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (controllerLastName.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Last Name is Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (controllerEmail.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Email Address is Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (controllerPassword.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Password is Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (controllerCPassword.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Confirm Password is Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (controllerCPassword.text !=
                        controllerPassword.text) {
                      Fluttertoast.showToast(
                          msg: "Password Not Match",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Register();
                    }
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
