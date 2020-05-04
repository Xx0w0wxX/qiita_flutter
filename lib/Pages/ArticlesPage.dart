import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qiitaarticles/Models/Article.dart';
import 'package:qiitaarticles/Models/User.dart';
import 'package:qiitaarticles/Providers/UserProvider.dart';
import 'package:qiitaarticles/Requests/QiitaRequest.dart';


class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  User user;
  Article article;
  List<Article> articles;

  @override
  Widget build(BuildContext context) {
    setState(() {
      user = Provider.of<UserProvider>(context, listen: false).getUser();

      Qiita(user.id).fetchUserArticles().then((data) {
        Iterable list = json.decode(data.body);
        setState(() {
          articles = list.map((model) => Article.fromJson(model)).toList();
        });
      });
    });

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.grey,), onPressed: () {
                  Navigator.pop(context);
              },
              ),
              backgroundColor: Colors.greenAccent,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      SizedBox(height: 20,),
                      Text(user.name, style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.mood, color: Colors.deepOrangeAccent,),
                            Text(user.followeesCount.toString(), style: TextStyle(fontSize: 20),),
                            Icon(Icons.opacity, color: Colors.deepOrangeAccent,),
                            Text(user.followersCount.toString(), style: TextStyle(fontSize: 20),),
                            Icon(Icons.note, color: Colors.black38,),
                            Text(user.itemsCount.toString(), style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 600,
                  child:
                  articles != null ?
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: articles.length,
                        itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 400,
                                    child: Text(articles[index].title, style: TextStyle(fontSize: 12.0),),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.favorite, color: Colors.pink,),
                                      Text(articles[index].likesCount.toString(), style: TextStyle(fontSize: 10.0),),
                                      Icon(Icons.comment, color: Colors.black38,),
                                      Text(articles[index].commentsCount.toString(), style: TextStyle(fontSize: 10.0),),
                                    ],
                                  )
                                ],
                              )
                            );
                        },
                      ) :
                  Container(child: Align(child: Text('data is loading'))),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

