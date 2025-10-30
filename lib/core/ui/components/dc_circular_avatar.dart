import 'dart:typed_data';
import 'package:flutter/material.dart';

class DCCircularAvatar extends StatelessWidget {
  final Uint8List? imageBytes;
  final double radius;
  final IconData fallbackIcon;
  final Color? backgroundColor;
  final Color? iconColor;

  const DCCircularAvatar({
    super.key,
    this.imageBytes,
    this.radius = 24.0,
    this.fallbackIcon = Icons.person,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    if (imageBytes != null && imageBytes!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.grey[300],
        backgroundImage: MemoryImage(imageBytes!),
        child: Container(),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[300],
      child: Icon(
        fallbackIcon,
        color: iconColor ?? Colors.grey[600],
        size: radius,
      ),
    );
  }
}
