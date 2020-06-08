import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qiitaarticles/Models/User.dart';
import 'package:qiitaarticles/Pages/ArticlesPage.dart';
import 'package:qiitaarticles/Requests/QiitaRequest.dart';

class UserNotifier with ChangeNotifier {
  final TextEditingController usernameTextEditingController = TextEditingController();

  User user;
  String errorMessage;
  bool loading = false;

  Future<bool> fetchUser(username) async {
    setLoading(true);

    await Qiita(username).fetchUser().then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setUser(User.fromJson(json.decode(data.body)));
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return _isUser();
  }

  Future<void> getArticles({
    @required BuildContext context,
  }) async {
    if (usernameTextEditingController.text.isEmpty) {
      setMessage(('Please enter your username'));
    } else {
      await fetchUser(usernameTextEditingController.text);
      if (_isUser()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlesPage(),
          ),
        );
      }
    }
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool get isLoading => loading;

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  User get getUser => user;

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String get getMessage => errorMessage;

  bool _isUser() {
    return user != null ? true : false;
  }
}
