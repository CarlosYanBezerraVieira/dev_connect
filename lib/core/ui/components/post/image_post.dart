import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImagePost extends StatelessWidget {
  final Uint8List authorImageBytes;
  final String title;
  final double? height;
  const ImagePost(
      {super.key,
      required this.authorImageBytes,
      this.height,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final relativeHeight = height ?? MediaQuery.of(context).size.height * 0.3;
    const double sizeSectionAuthor = 30;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.memory(
            authorImageBytes,
            width: double.infinity,
            height: relativeHeight,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          width: double.infinity,
          height: sizeSectionAuthor,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withAlpha(50),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
