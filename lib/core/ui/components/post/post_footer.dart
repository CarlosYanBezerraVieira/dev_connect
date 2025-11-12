import 'package:dev_connect/core/ui/components/post/post_actions.dart';
import 'package:dev_connect/core/ui/components/post/post_timestamp.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class PostFooter extends StatelessWidget {
  final String author;
  final Uint8List? authorImageBytes;
  final DateTime? createdAt;
  final String description;
  final bool isLiked;
  final int likeCount;
  final VoidCallback onLike;

  const PostFooter({
    super.key,
    required this.author,
    this.authorImageBytes,
    this.createdAt,
    required this.description,
    required this.isLiked,
    required this.likeCount,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(
                 height: 4,
              ),
              PostTimestamp(createdAt: createdAt),
            ],
          ),
          PostActions(
            isLiked: isLiked,
            likeCount: likeCount,
            onLike: onLike,
          ),
        ],
      ),
    );
  }
}
