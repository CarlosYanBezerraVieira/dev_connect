import 'package:dev_connect/core/ui/components/dc_circular_avatar.dart';
import 'package:dev_connect/core/ui/components/post/post_timestamp.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class PostHeader extends StatelessWidget {
  final String author;
  final Uint8List? authorImageBytes;
  final DateTime? createdAt;

  const PostHeader({
    super.key,
    required this.author,
    this.authorImageBytes,
    this.createdAt,
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              PostTimestamp(createdAt: createdAt),
            ],
          ),
        ),
      ],
    );
  }
}
