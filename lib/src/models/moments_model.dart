class ReelsModel {
  int? id;
  String? url;
  int? likeCount;
  int? commentCount;
  int? sendCount;
  bool? isLiked;
  String? musicName;
  String? musicImageUrl;
  String? description;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<ReelComments>? reelComments;

  ReelsModel(
      {this.id,
      this.url,
      this.likeCount,
      this.commentCount,
      this.sendCount,
      this.isLiked,
      this.musicName,
      this.musicImageUrl,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.reelComments});

  ReelsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    sendCount = json['send_count'];
    isLiked = json['is_liked'];
    musicName = json['music_name'];
    musicImageUrl = json['music_image_url'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['reel_comments'] != null) {
      reelComments = <ReelComments>[];
      json['reel_comments'].forEach((v) {
        reelComments!.add(new ReelComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['like_count'] = this.likeCount;
    data['comment_count'] = this.commentCount;
    data['send_count'] = this.sendCount;
    data['is_liked'] = this.isLiked;
    data['music_name'] = this.musicName;
    data['music_image_url'] = this.musicImageUrl;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.reelComments != null) {
      data['reel_comments'] =
          this.reelComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? userId;
  String? userName;
  String? profileUrl;
  bool? isFollow;
  String? createdAt;
  String? updatedAt;

  User(
      {this.userId,
      this.userName,
      this.profileUrl,
      this.isFollow,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    profileUrl = json['profile_url'];
    isFollow = json['is_follow'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['profile_url'] = this.profileUrl;
    data['is_follow'] = this.isFollow;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ReelComments {
  int? id;
  String? cmment;
  String? createdAt;
  String? updatedAt;
  User? user;

  ReelComments(
      {this.id, this.cmment, this.createdAt, this.updatedAt, this.user});

  ReelComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cmment = json['cmment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cmment'] = this.cmment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
