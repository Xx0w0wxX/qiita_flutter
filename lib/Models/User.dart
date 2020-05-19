class User {
  String description;
  String facebookId;
  int followeesCount;
  int followersCount;
  String githubLoginName;
  String id;
  int itemsCount;
  String linkedinId;
  String location;
  String name;
  String organization;
  int permanentId;
  String profileImageUrl;
  bool teamOnly;
  String twitterScreenName;
  String websiteUrl;

  User(
      {this.description,
      this.facebookId,
      this.followeesCount,
      this.followersCount,
      this.githubLoginName,
      this.id,
      this.itemsCount,
      this.linkedinId,
      this.location,
      this.name,
      this.organization,
      this.permanentId,
      this.profileImageUrl,
      this.teamOnly,
      this.twitterScreenName,
      this.websiteUrl});

  User.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    facebookId = json['facebook_id'];
    followeesCount = json['followees_count'];
    followersCount = json['followers_count'];
    githubLoginName = json['github_login_name'];
    id = json['id'];
    itemsCount = json['items_count'];
    linkedinId = json['linkedin_id'];
    location = json['location'];
    name = json['name'];
    organization = json['organization'];
    permanentId = json['permanent_id'];
    profileImageUrl = json['profile_image_url'];
    teamOnly = json['team_only'];
    twitterScreenName = json['twitter_screen_name'];
    websiteUrl = json['website_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['facebook_id'] = this.facebookId;
    data['followees_count'] = this.followeesCount;
    data['followers_count'] = this.followersCount;
    data['github_login_name'] = this.githubLoginName;
    data['id'] = this.id;
    data['items_count'] = this.itemsCount;
    data['linkedin_id'] = this.linkedinId;
    data['location'] = this.location;
    data['name'] = this.name;
    data['organization'] = this.organization;
    data['permanent_id'] = this.permanentId;
    data['profile_image_url'] = this.profileImageUrl;
    data['team_only'] = this.teamOnly;
    data['twitter_screen_name'] = this.twitterScreenName;
    data['website_url'] = this.websiteUrl;
    return data;
  }
}
