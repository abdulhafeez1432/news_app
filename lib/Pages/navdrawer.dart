import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/Screens/AdFavorite/add_favorite.dart';
import 'package:news_app/Screens/Login/login_screen.dart';
import 'package:news_app/Screens/Signup/signup_screen.dart';


class NavDrawer extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    void toRegister() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SignUpScreen()));
    }

    void toCategory() {

    }

    void toFavorite() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddFavorite()));
    }

    void toFavoriteDetails() {

    }

    void toNewCategory() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginScreen()));
    }



    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Welcome"),
            accountEmail:
            Text("To The World"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Category'),
            onTap: toCategory,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Register'),
            onTap: toRegister,
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: toNewCategory,
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
            onTap: toFavorite,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite Details'),
            onTap: toFavoriteDetails,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
