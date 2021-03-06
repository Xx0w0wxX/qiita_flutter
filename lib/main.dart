import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qiitaarticles/Models/User.dart';
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 100),
              const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        'https://images-tech-blog.s-yoshiki.com/wp-content/uploads/2020/02/01145213/qiita-icon-300x300.png'),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'QIITA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 150),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(.1),
                ),
                child: TextField(
                  onChanged: (value) {
                    userNotifier.setMessage(null);
                  },
                  controller: userNotifier.usernameTextEditingController,
                  enabled: !context.select((UserNotifier n) => n.isLoading),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    errorText: context.select((UserNotifier n) => n.getMessage),
                    border: InputBorder.none,
                    hintText: "Qiita username",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                padding: EdgeInsets.all(20),
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  child: context.select((UserNotifier n) => n.isLoading)
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
                  userNotifier.getArticles(context: context);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
