import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/Http/connections.dart';
import 'package:news_app/Model/new_category.dart';
import 'package:news_app/Model/news_bycategory.dart';
import 'package:news_app/Pages/home.dart';
import 'package:news_app/constant/constant.dart';
import 'package:news_app/constant/utilis.dart';
import 'package:news_app/widget/my_dropdown.dart';

import '../../constants.dart';

class AddFavorite extends StatefulWidget {
  const AddFavorite({Key? key}) : super(key: key);

  @override
  _AddFavoriteState createState() => _AddFavoriteState();
}

class _AddFavoriteState extends State<AddFavorite> {

  void toHomePage(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => HomePage()));


  }

  late Future<List<NewsCategory>> fetchResult;
  late Future<List<Site>> fetchSiteResult;
  NewsCategory? selectedCategory;
  int? selectedSiteIndex;
  bool isloading = false;
  final sharedPref = SharedPref();




  @override
  void initState() {
    fetchResult = fetchCategory();
    fetchSiteResult = fetchSites();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Favorite'),
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Visibility(
                      visible: isloading,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10),
                      buildCAtegoryText("Select Category"),
                      SizedBox(width: 10),
                      buildCategoryUI(context),
                      buildCAtegoryText("Select Site"),
                      SizedBox(width: 10),
                      buildSiteUI(context),
                      SizedBox(
                        width: 10,
                        height: 40,
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        padding: EdgeInsets.all(5),
                        onPressed: () async {
                          if (selectedSiteIndex != null &&
                              selectedCategory != null) {
                            setState(() {
                              isloading = true;
                            });
                            var result = await addToFavorite(
                                selectedCategory!.id, selectedSiteIndex ?? 0);

                                if (result){
                                  Fluttertoast.showToast(
                                    msg: "You Have Added Favorite Successful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  toHomePage(context);

                                }


                                else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Internal server error")));
                                }
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                Text("Select category or site missing")));
                          }
                          setState(() {
                            isloading = false;
                          });
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  buildCategoryUI(BuildContext context) {
    return FutureBuilder<List<NewsCategory>>(
        future: fetchResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("snapshot=${snapshot.data}");
            return MyDropDown(
              fillColor: Colors.white,
              rightPadding: 10,
              leftPadding: 10,
              prefixIcon: "",
              hintColor: Colors.black,
              labelColor: Colors.black,
              borderColor: Colors.black,
              onChange: (value) {
                snapshot.data!.forEach((element) {
                  if (element.name == value) {
                    selectedCategory = element;
                  }
                });

                print(value);
              },
              hintText: 'Select Category',
              labelText: 'Select Category',
              items: getListOfNewsString(snapshot.data),
              value: 'Select Category',
              validator: (string) {
                if (string == null ||
                    string.isEmpty ||
                    string == 'Select Category') {
                  return "Select Category";
                }
                return null;
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  buildSiteUI(BuildContext context) {
    return FutureBuilder<List<Site>>(
        future: fetchSiteResult,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyDropDown(
                fillColor: Colors.white,
                rightPadding: 10,
                leftPadding: 10,
                prefixIcon: "",
                hintColor: Colors.black,
                suffixIcon: "",
                labelColor: Colors.black,
                borderColor: Colors.black,
                onChange: (value) {
                  for (var index = 0; index < snapshot.data!.length; ++index) {
                    if (snapshot.data![index].name == value) {
                      selectedSiteIndex = index;
                    }
                  }

                  print(value);
                },
                hintText: 'Select Site',
                labelText: 'Select Site',
                items: getListOfSites(snapshot.data),
                value: 'Select Site',
                validator: (string) {
                  if (string == null ||
                      string.isEmpty ||
                      string == 'Select Site') {
                    return "Select Site";
                  }
                  return null;
                },
              );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  Align buildCAtegoryText(String heading) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 19.0),
        child: Row(
          children: [
            Text(heading, style: kNonActiveTabStyle),
            SizedBox(width: 10),
            SizedBox(height: 50),
            //Icon(Icons.backup_table_sharp),
          ],
        ),
      ),
    );
  }

  List<String> getListOfNewsString(List<NewsCategory>? data) {
    List<String> list = [];
    list.add("Select Category");
    if (data != null) {
      data.forEach((element) {
        list.add(element.name);
      });
    }
    return list;
  }

  List<String> getListOfSites(List<Site>? data) {
    List<String> list = [];
    list.add("Select Site");

    if (data != null) {
      data.forEach((element) {
        list.add(element.name!);
      });
    }
    return list;
  }
}
