import 'package:flutter/material.dart';

class SnackBarHelper {
  SnackBarHelper._();

  static void showError(BuildContext context, String message) {
    if (message.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
