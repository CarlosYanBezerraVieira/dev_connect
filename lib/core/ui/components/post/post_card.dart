import 'package:dev_connect/core/ui/components/post/post_actions.dart';
import 'package:dev_connect/core/ui/components/post/post_header.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }
}
