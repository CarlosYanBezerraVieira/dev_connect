import 'package:dev_connect/core/ui/components/action_button.dart';
import 'package:dev_connect/core/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  const PostActions({
    super.key,
    required this.likeCount,
    required this.isLiked,
    required this.onLike,
  });

  final int likeCount;
  final bool isLiked;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ActionButton(
          icon: isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? AppColors.error : AppColors.midGray,
          label: likeCount.toString(),
          onTap: onLike,
        ),
      ],
    );
  }
}
