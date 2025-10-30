import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:typed_data';

part 'post_model.g.dart';

Uint8List _base64ToUint8List(String? json) {
  if (json == null || json.isEmpty) return Uint8List(0);
  try {
    return base64Decode(json);
  } catch (_) {
    return Uint8List(0);
  }
}

String _uint8ListToBase64(Uint8List object) {
  if (object.isEmpty) return '';
  return base64Encode(object);
}

@HiveType(typeId: 1)
@JsonSerializable()
class Post extends HiveObject {
  @HiveField(0)
  @JsonKey(name: "_id")
  final String id;

  @HiveField(1)
  final String author;

  @HiveField(2)
  @JsonKey(
    name: 'authorImageBytes',
    fromJson: _base64ToUint8List,
    toJson: _uint8ListToBase64,
  )
  final Uint8List authorImageBytes;

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
    Uint8List? authorImageBytes,
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
