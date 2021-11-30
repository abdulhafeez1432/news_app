import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Pages/home.dart';
import 'package:news_app/Screens/AdFavorite/add_favorite.dart';
import 'package:news_app/Screens/Login/components/background.dart';
import 'package:news_app/Screens/Signup/signup_screen.dart';
import 'package:news_app/components/already_have_an_account_acheck.dart';
import 'package:news_app/components/rounded_button.dart';
import 'package:news_app/components/text_field_container.dart';
import 'package:news_app/constant/utilis.dart';
import 'package:news_app/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  void toHomePage(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => HomePage()));


  }
  void toAddFavorite(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AddFavorite()));
  }





  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();

  final SharedPref sharedPref = SharedPref();

  Future login() async {
    String BASE_URL = 'http://api.allnigerianewspapers.com.ng/api';
    final response = await http.post(
      Uri.parse('http://api.allnigerianewspapers.com.ng/api/login/'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(
        {
          "username": controllerUsername.text,
          "password": controllerPassword.text,
        },
      ),
    );



    print("This is working fine ${response.statusCode}");
    var data = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      print("Working here");
      await sharedPref.setString('token', data['login']['token']);
      await sharedPref.setString('user_id', data['user_id'].toString());
      await sharedPref.setString('username', controllerUsername.text);
      await sharedPref.setString('password', controllerPassword.text);
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
          toHomePage(context);
          //toAddFavorite(context);

    } else {
      Fluttertoast.showToast(
          msg: "Invalid Username or Password",
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      alignment: Alignment.center,
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "WELCOME TO \nLOGIN PAGE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              obscureText: false,
              cursorColor: kPrimaryColor,
              controller: controllerUsername,
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
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: controllerPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
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
            SizedBox(
              height: 50,
              width: 300,
              child: FlatButton(
                color: Color(0xFF81C784),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                onPressed: () {
                  print("Printing Login");
                  if (controllerUsername.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "UserName is Required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  } else if (controllerPassword.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Password is Required",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return;
                  }
                  login();
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
