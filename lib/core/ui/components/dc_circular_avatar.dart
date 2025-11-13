import 'dart:typed_data';
import 'package:dev_connect/core/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DCCircularAvatar extends StatelessWidget {
  final Uint8List? imageBytes;
  final double radius;
  final IconData fallbackIcon;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const DCCircularAvatar({
    super.key,
    this.imageBytes,
    this.radius = 24.0,
    this.fallbackIcon = Icons.person,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    if (onTap == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor ?? Colors.grey[300],
            backgroundImage: (imageBytes != null && imageBytes!.isNotEmpty)
                ? MemoryImage(imageBytes!)
                : null,
            child: (imageBytes == null || imageBytes!.isEmpty)
                ? Icon(
                    fallbackIcon,
                    color: iconColor ?? Colors.grey[600],
                    size: radius,
                  )
                : null,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.camera_alt,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
