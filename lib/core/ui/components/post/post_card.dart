import 'package:dev_connect/core/ui/components/post/post_actions.dart';
import 'package:dev_connect/core/ui/components/post/post_header.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(12);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PostHeader(
                author: post.author,
                authorImageUrl: post.authorImageUrl,
              ),
              const SizedBox(height: 12),
              Text(post.content, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              PostActions(
                isLiked: post.isLiked,
                likeCount: post.likes,
                commentCount: post.comments,
                onLike: onLike,
                onComment: onComment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
