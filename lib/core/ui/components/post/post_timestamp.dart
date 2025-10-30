import 'package:flutter/material.dart';
import 'package:dev_connect/core/formatters/date_formatter.dart';

class PostTimestamp extends StatelessWidget {
  final DateTime? createdAt;
  final TextStyle? textStyle;

  const PostTimestamp({
    super.key,
    required this.createdAt,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormatter.formatRelativeDate(createdAt),
      style: textStyle ?? Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Colors.grey[600],
      ),
    );
  }
}
