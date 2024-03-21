import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  String? id;
  @JsonKey(name: 'user_id')
  String? userId;
  String? name;
  String? username;
  @JsonKey(name: 'user_avatar')
  String? userAvatar;
  @JsonKey(name: 'is_merchant')
  bool? isMerchant;
  @JsonKey(name: 'restaurant_name')
  String? restaurantName;
  @JsonKey(name: 'restaurant_image')
  String? restaurantImage;
  String? reply;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'moments_passed')
  String? momentsPassed;
  @JsonKey(name: 'reply_to')
  String? replyTo;

  Item({
    this.id,
    this.userId,
    this.name,
    this.username,
    this.userAvatar,
    this.isMerchant,
    this.restaurantName,
    this.restaurantImage,
    this.reply,
    this.createdAt,
    this.momentsPassed,
    this.replyTo,
  });

  @override
  String toString() {
    return 'Item(id: $id, userId: $userId, name: $name, username: $username, userAvatar: $userAvatar, isMerchant: $isMerchant, restaurantName: $restaurantName, restaurantImage: $restaurantImage, reply: $reply, createdAt: $createdAt, momentsPassed: $momentsPassed, replyTo: $replyTo)';
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    String? id,
    String? userId,
    String? name,
    String? username,
    String? userAvatar,
    bool? isMerchant,
    String? restaurantName,
    String? restaurantImage,
    String? reply,
    String? createdAt,
    String? momentsPassed,
    String? replyTo,
  }) {
    return Item(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      username: username ?? this.username,
      userAvatar: userAvatar ?? this.userAvatar,
      isMerchant: isMerchant ?? this.isMerchant,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      reply: reply ?? this.reply,
      createdAt: createdAt ?? this.createdAt,
      momentsPassed: momentsPassed ?? this.momentsPassed,
      replyTo: replyTo ?? this.replyTo,
    );
  }
}
