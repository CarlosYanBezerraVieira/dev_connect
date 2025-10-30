import 'package:dev_connect/core/ui/components/dc_circular_avatar.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class PostHeader extends StatelessWidget {
  final String author;
  final Uint8List? authorImageBytes;

  const PostHeader({
    super.key,
    required this.author,
    this.authorImageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DCCircularAvatar(
          imageBytes: authorImageBytes,
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
