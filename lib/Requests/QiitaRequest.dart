import 'package:http/http.dart' as http;

class Qiita {
  final String userName;
  final String url = 'https://qiita.com/api/v2';

  Qiita(this.userName);

  Future<http.Response> fetchUser() {
    return http.get(url + '/users/' + userName);
  }

  Future<http.Response> fetchUserArticles() {
    return http.get(url + '/users/' + userName + '/items?per_page=100');
  }
}
