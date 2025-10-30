import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DCLoading extends StatelessWidget {
  const DCLoading({super.key, this.size = 56, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color resolved = color ?? Theme.of(context).colorScheme.primary;
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: resolved,
        size: size,
      ),
    );
  }
}
