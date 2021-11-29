import 'package:flutter/material.dart';
import 'package:news_app/Screens/Login/login_screen.dart';
import 'package:news_app/Screens/Signup/signup_screen.dart';


class OnboardingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void toLoginPage(context) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginScreen()));
    }


    void toRegsiterPage() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SignUpScreen()));
    }




    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/welcome_newspaper.png'),
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 300),

                  SizedBox(height: 100),
                  Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'All Nigeria Newspaper',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 0, 5, 0),
                        child: Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          toLoginPage(context);
                        },
                        child: Text(
                          'SignIn Now',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      color: Color(0xFF81C784),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      onPressed: () {
                        toRegsiterPage();
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
          ),
        ],
      )),
    );
  }
}
