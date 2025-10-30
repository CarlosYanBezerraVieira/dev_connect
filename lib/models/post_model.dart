import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Post extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "_id")
  final String id;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String authorImageBytes;

  @HiveField(3)
  final String content;

  @HiveField(4)
   int likes;

  @HiveField(5)
   bool isLiked;

  Post({
    required this.id,
    required this.author,
    required this.authorImageBytes,
    required this.content,
    required this.likes,
    this.isLiked = false,
  });

  Post copyWith({
    String? id,
    String? author,
    String? authorImageBytes,
    String? content,
    int? likes,
    bool? isLiked,
  }) {
    return Post(
      id: id ?? this.id,
      author: author ?? this.author,
      authorImageBytes: authorImageBytes ?? this.authorImageBytes,
      content: content ?? this.content,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
