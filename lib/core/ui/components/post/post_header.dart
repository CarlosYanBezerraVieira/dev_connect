import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String author;
  final String authorImageUrl;

  const PostHeader({
    super.key,
    required this.author,
    required this.authorImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(authorImageUrl),
          radius: 20,
        ),
        const SizedBox(width: 12),
        Text(
          author,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
