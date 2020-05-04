import 'package:qiitaarticles/Models/User.dart';

class Article {
  String renderedBody;
  String body;
  bool coediting;
  int commentsCount;
  String createdAt;
  Null group;
  String id;
  int likesCount;
  bool private;
  int reactionsCount;
  List<Tags> tags;
  String title;
  String updatedAt;
  String url;
  User user;
  Null pageViewsCount;

  Article(
      {this.renderedBody,
        this.body,
        this.coediting,
        this.commentsCount,
        this.createdAt,
        this.group,
        this.id,
        this.likesCount,
        this.private,
        this.reactionsCount,
        this.tags,
        this.title,
        this.updatedAt,
        this.url,
        this.user,
        this.pageViewsCount});

  Article.fromJson(Map<String, dynamic> json) {
    renderedBody = json['rendered_body'];
    body = json['body'];
    coediting = json['coediting'];
    commentsCount = json['comments_count'];
    createdAt = json['created_at'];
    group = json['group'];
    id = json['id'];
    likesCount = json['likes_count'];
    private = json['private'];
    reactionsCount = json['reactions_count'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    title = json['title'];
    updatedAt = json['updated_at'];
    url = json['url'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    pageViewsCount = json['page_views_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered_body'] = this.renderedBody;
    data['body'] = this.body;
    data['coediting'] = this.coediting;
    data['comments_count'] = this.commentsCount;
    data['created_at'] = this.createdAt;
    data['group'] = this.group;
    data['id'] = this.id;
    data['likes_count'] = this.likesCount;
    data['private'] = this.private;
    data['reactions_count'] = this.reactionsCount;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['page_views_count'] = this.pageViewsCount;
    return data;
  }
}

class Tags {
  String name;
  List<Null> versions;

  Tags({this.name, this.versions});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['versions'] != null) {
      versions = new List<Null>();
      json['versions'].forEach((v) {
        versions.add(Null);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.versions != null) {
      data['versions'] = '';
    }
    return data;
  }
}
