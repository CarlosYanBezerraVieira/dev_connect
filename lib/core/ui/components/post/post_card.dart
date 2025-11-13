import 'package:dev_connect/core/ui/components/post/post_footer.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:flutter/material.dart';

import 'image_post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ImagePost(
              title: post.author,
              authorImageBytes: post.authorImageBytes,
            ),
            PostFooter(
              description: post.content,
              onLike: onLike,
              likeCount: post.likes,
              isLiked: post.isLiked,
              author: post.author,
              authorImageBytes: post.authorImageBytes,
              createdAt: post.createdAt,
            ),
          ],
        ),
      ),
    );
  }
}
