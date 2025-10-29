import 'package:dev_connect/core/ui/components/action_button.dart';
import 'package:dev_connect/core/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final bool isLiked;
  final int likeCount;
  final int commentCount;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostActions({
    super.key,
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ActionButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          label: likeCount.toString(),
          onTap: onLike,
          color: isLiked ? AppColors.error : AppColors.midGray,
        ),
        ActionButton(
          icon: Icons.comment_outlined,
          label: commentCount.toString(),
          onTap: onComment,
          color: AppColors.midGray,
        ),
      ],
    );
  }
}
