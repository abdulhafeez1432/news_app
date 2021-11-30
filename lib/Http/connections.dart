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
  var token = await sharedPref.getString('token');
  final response = await http.get(
    Uri.parse('${BASE_URL}favoritedetails/'),
    headers: Utils.configHeader(token: token),
  );



  var favmodel;
  if (response.statusCode == 200) {
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

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Site>((json) => Site.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load Site');
  }
}

Future<bool> addToFavorite(int categorId, int siteId) async {
  var token = await sharedPref.getString('token');
  final response = await http.post(
    Uri.parse('${BASE_URL}addfavorite/'),
    body: jsonEncode(<String, int>{"category": categorId, "site": siteId}),
    headers: Utils.configHeader(token: token),
  );

  if (response.statusCode == 201) {

    //return Author.fromJson(json.decode(response.body));

    return Future.value(true);
  } else {

    return Future.value(false);
  }
}


Future<PostResponse> fetchSite(String? page, String site) async {
  final response = await http.get(Uri.parse(page ??
      'https://api.allnigerianewspapers.com.ng/api/newscategory/$site'));
  var newsModel;
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    newsModel = PostResponse.fromJson(jsonDecode(response.body));
    return newsModel;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load News');
  }
}
