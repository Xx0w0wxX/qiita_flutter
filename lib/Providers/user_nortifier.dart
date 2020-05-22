import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:qiitaarticles/Models/User.dart';
import 'package:qiitaarticles/Requests/QiitaRequest.dart';

class UserNotifier with ChangeNotifier {
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

    return isUser();
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

  bool isUser() {
    return user != null ? true : false;
  }
}
