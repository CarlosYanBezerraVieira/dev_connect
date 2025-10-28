import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dev_connect/core/routes/app_routes.dart';

class PostDetailPage extends StatelessWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post $postId')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Post details for id: $postId'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // voltar para o feed
                context.go(AppRoutes.feed);
              },
              child: const Text('Back to Feed'),
            ),
          ],
        ),
      ),
    );
  }
}
