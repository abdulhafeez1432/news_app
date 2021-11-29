import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Http/connections.dart';
import 'package:news_app/Model/favorite_details.dart';
import 'package:news_app/Model/news.dart';
import 'package:news_app/Model/post.dart';
import 'package:news_app/Pages/details.dart';
import 'package:news_app/Pages/navdrawer.dart';
import 'package:news_app/constant/constant.dart';
import 'package:news_app/constant/utilis.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  void toRefresh() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }





  List<FavoriteDetails>? favDetails;

  Future<List<FavoriteDetails>> getDataList() async {
    return favDetails = await getFavorite();
  }

  bool navBarMode = false;

  List<Post> posts = [];
  String? page;

  bool loading = true;
  String? error;

  Future<void> fetchPosts() async {
    try {
      PostResponse res = await getNews(page);

      posts.addAll(res.posts);
      page = res.nextUrl;

      loading = false;
    } catch (e) {
      loading = false;
      error = e.toString();
    }

  }


  @override
  void initState() {
    super.initState();
    getDataList();

    WidgetsBinding.instance!.addPostFrameCallback((_) => fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Nigeria NewsPaper"),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),

      drawer: NavDrawer(),

      //floating action button position to center
      bottomNavigationBar: ConvexAppBar(

        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.games, title: 'Games'),
          TabItem(icon: Icons.refresh, title: 'Refresh'),
          TabItem(icon: Icons.movie, title: 'Movies'),
          TabItem(icon: Icons.book, title: 'Books'),
        ],
            //onTap: onItemTapped,
            activeColor: Colors.white,
            backgroundColor: Colors.green[800],
            initialActiveIndex: 2,

      ),
      body: SingleChildScrollView(

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: kGrey3, width: 1.0),
              ),
              child: _buildFutureBuilder() ,

            ),
            _buildPostsList(context),
          ],
        ),
      )
    );
  }

  FutureBuilder<List<FavoriteDetails>> _buildFutureBuilder() {
    return FutureBuilder(
          future: getDataList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: double.infinity,
                height: 300.0,
                padding: EdgeInsets.only(left: 18.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: favDetails!.length.toInt(),
                    itemBuilder: (context, index) {
                      return favDetails == null
                          ? Container(
                        child: Text("Not Having Data"),
                      )
                          : InkWell(
                        onTap: () {
                          print("Working Fine");
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12.0),
                          child: Container(
                            width: 300.0,
                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: kGrey3, width: 1.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5.0,
                                      backgroundColor: kGrey1,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(favDetails![index].category!.name.toString(), style: kCategoryTitle)
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Expanded(
                                  child: Hero(
                                    tag: favDetails![index].site!.name.toString(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                          image: NetworkImage(favDetails![index].imageUrl.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  favDetails![index].title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: kTitleCard,
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(favDetails![index].uploaded.toString(), style: kDetailContent),
                                    SizedBox(width: 10.0),
                                    CircleAvatar(
                                      radius: 5.0,
                                      backgroundColor: kGrey1,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(favDetails![index].site!.name.toString(), style: kDetailContent)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          });
  }

  Widget _buildPostsList(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Text(error!);
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: posts.length + 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index >= posts.length) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            fetchPosts();
          });

          return Center(
            child: CircularProgressIndicator(),
          );
        }
        Post post = posts[index];

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetails(post: post)));
          },
          child: Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: Colors.white24.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.height * 0.15,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/circle-loading-animation.gif',
                      image: post.imageUrl,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: Wrap(
                      children: [
                        Text(
                          post.title,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Noticia Text',
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.pinkAccent,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Text(
                                  post.category.name.toLowerCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(post.site.name),
                              Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
