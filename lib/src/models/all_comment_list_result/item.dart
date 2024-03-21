import 'package:json_annotation/json_annotation.dart';
import 'package:max_moments/src/models/all_reply_list_result/replies.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  int? number;
  String? id;
  @JsonKey(name: 'moment_id')
  String? momentId;
  @JsonKey(name: 'user_id')
  String? userId;
  String? name;
  String? username;
  @JsonKey(name: 'is_merchant')
  bool? isMerchant;
  @JsonKey(name: 'restaurant_name')
  String? restaurantName;
  @JsonKey(name: 'restaurant_image')
  String? restaurantImage;
  @JsonKey(name: 'user_avatar')
  String? userAvatar;
  String? comment;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'moments_passed')
  String? momentsPassed;
  @JsonKey(name: 'reply_count')
  int? replyCount;
  Replies? replies;

  Item(
      {this.number,
      this.id,
      this.momentId,
      this.userId,
      this.name,
      this.username,
      this.isMerchant,
      this.restaurantName,
      this.restaurantImage,
      this.userAvatar,
      this.comment,
      this.createdAt,
      this.momentsPassed,
      this.replyCount,
      this.replies});

  @override
  String toString() {
    return 'Item(number: $number, id: $id, momentId: $momentId, userId: $userId, name: $name, username: $username, isMerchant: $isMerchant, restaurantName: $restaurantName, restaurantImage: $restaurantImage, userAvatar: $userAvatar, comment: $comment, createdAt: $createdAt, momentsPassed: $momentsPassed, replyCount: $replyCount)';
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    int? number,
    String? id,
    String? momentId,
    String? userId,
    String? name,
    String? username,
    bool? isMerchant,
    String? restaurantName,
    String? restaurantImage,
    String? userAvatar,
    String? comment,
    String? createdAt,
    String? momentsPassed,
    int? replyCount,
  }) {
    return Item(
      number: number ?? this.number,
      id: id ?? this.id,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      username: username ?? this.username,
      isMerchant: isMerchant ?? this.isMerchant,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      userAvatar: userAvatar ?? this.userAvatar,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      momentsPassed: momentsPassed ?? this.momentsPassed,
      replyCount: replyCount ?? this.replyCount,
    );
  }
}
