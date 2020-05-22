import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qiitaarticles/Pages/ArticlesPage.dart';
import 'package:qiitaarticles/Providers/user_nortifier.dart';

void main() => runApp(
    ChangeNotifierProvider<UserNotifier>(
      create: (context) => UserNotifier(),
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();

  void _getArticles() {
    if (_controller.text == '') {
      Provider.of<UserNotifier>(context, listen: false)
          .setMessage(('Please enter your username'));
    } else {
      Provider.of<UserNotifier>(context, listen: false)
          .fetchUser(_controller.text)
          .then((value) {
        if (value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ArticlesPage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://images-tech-blog.s-yoshiki.com/wp-content/uploads/2020/02/01145213/qiita-icon-300x300.png'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'QIITA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(.1),
                ),
                child: TextField(
                  onChanged: (value) {
                    Provider.of<UserNotifier>(context, listen: false)
                        .setMessage(null);
                  },
                  controller: _controller,
                  enabled: !Provider.of<UserNotifier>(context, listen: false)
                      .isLoading,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    errorText: Provider.of<UserNotifier>(context, listen: false)
                        .getMessage,
                    border: InputBorder.none,
                    hintText: "Qiita username",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: EdgeInsets.all(20),
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  child: Provider.of<UserNotifier>(context, listen: false)
                          .isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          'See Articles',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
                onPressed: () {
                  _getArticles();
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
