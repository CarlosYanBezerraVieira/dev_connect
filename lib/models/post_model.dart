import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Post extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String authorImageUrl;

  @HiveField(3)
  final String content;

  @HiveField(4)
  int likes;

  @HiveField(5)
  int comments;

  @HiveField(6)
  bool isLiked;

  Post({
    required this.id,
    required this.author,
    required this.authorImageUrl,
    required this.content,
    this.likes = 0,
    this.comments = 0,
    this.isLiked = false,
  });
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
