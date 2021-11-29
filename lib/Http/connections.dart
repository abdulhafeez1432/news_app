// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/favorite_details.dart';
import 'package:news_app/Model/new_category.dart';
import 'package:news_app/Model/news_bycategory.dart';
import 'package:news_app/Model/post.dart';
import 'package:news_app/constant/utilis.dart';

final sharedPref = SharedPref();
String? token;
String BASE_URL = 'http://api.allnigerianewspapers.com.ng/api/';



Future<PostResponse> getNews(String? page) async {
  final response = await http.get(Uri.parse(page ?? '${BASE_URL}newstoday/'));
  if (response.statusCode == 200) {
    var newsModel = PostResponse.fromJson(jsonDecode(response.body.toString()));
    return newsModel;
  } else {
    throw Exception('Failed to load News');
  }
}

Future<List<FavoriteDetails>> getFavorite() async {
  token = await sharedPref.getString('token');
  final response = await http.get(
    Uri.parse('${BASE_URL}favoritedetails/'),
    headers: Utils.configHeader(token: token),
  );

  var favmodel;
  if (response.statusCode == 200) {

    print("get favorite response=${json.encode(response.body)} ");
    var list = json.decode(response.body) as List;
    List<FavoriteDetails> listOfFavorites =
    list.map((i) => FavoriteDetails.fromJson(i)).toList();
    return listOfFavorites;
  } else {

    throw Exception('Failed to load News');

  }
}

Future<List<NewsCategory>> fetchCategory() async {
  final response = await http
      .get(Uri.parse('${BASE_URL}category/'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed
        .map<NewsCategory>((json) => NewsCategory.fromMap(json))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Site>> fetchSites() async {
  String _mySelection;

  final response = await http
      .get(Uri.parse('${BASE_URL}site/'));

  if (response.statusCode == 200) {
    print("response site=${response.body}");
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Site>((json) => Site.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Site');
  }
}

Future<bool> addToFavorite(int categorId, int siteId) async {
  token = await sharedPref.getString('token');
  final response = await http.post(
    Uri.parse('${BASE_URL}addfavorite/'),
    body: jsonEncode(<String, int>{"category": categorId, "site": siteId}),
    headers: Utils.configHeader(token: token),
  );
  print(response.statusCode);
  if (response.statusCode == 201) {
    print(response.body);
    //return Author.fromJson(json.decode(response.body));
    print("added to favorite=${response.body}");
    return Future.value(true);
  } else {
    print('Error adding favorite ${response.body}');
    return Future.value(false);
  }
}



