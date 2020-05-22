import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qiitaarticles/Models/Article.dart';
import 'package:qiitaarticles/Models/User.dart';
import 'package:qiitaarticles/Providers/user_nortifier.dart';
import 'package:qiitaarticles/Requests/QiitaRequest.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage>
    with SingleTickerProviderStateMixin {
  User user;
  Article article;
  List<Article> articles;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _scaleScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    _scaleScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    setState(() {
      user = Provider.of<UserNotifier>(context, listen: false).getUser;

      Qiita(user.id).fetchUserArticles().then((data) {
        Iterable list = json.decode(data.body);
        setState(() {
          articles = list.map((model) => Article.fromJson(model)).toList();
        });
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          menu(context),
          wei(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(user.profileImageUrl),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  user.name,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.mood,
                        color: Colors.deepOrangeAccent,
                      ),
                      Text(
                        user.followeesCount.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.opacity,
                        color: Colors.deepOrangeAccent,
                      ),
                      Text(
                        user.followersCount.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.note,
                        color: Colors.black38,
                      ),
                      Text(
                        user.itemsCount.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget wei(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text(
                        user.name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Container(
                    height: 700,
                    child: articles != null
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200])),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.lightGreen
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            print(articles[index].title);
                                          },
                                          child: Container(
                                            width: 400,
                                            child: Text(
                                              articles[index].title,
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.pink,
                                            ),
                                            Text(
                                              articles[index]
                                                  .likesCount
                                                  .toString(),
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                            Icon(
                                              Icons.comment,
                                              color: Colors.black38,
                                            ),
                                            Text(
                                              articles[index]
                                                  .commentsCount
                                                  .toString(),
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                              );
                            },
                          )
                        : Container(child: Align(child: Text('Loading...'))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
