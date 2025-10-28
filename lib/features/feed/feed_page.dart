import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dev_connect/core/routes/app_routes.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // navega para detalhes do post com id de exemplo
                final String path = AppRoutes.postDetail.replaceFirst(':id', '42');
                context.go(path);
              },
              child: const Text('Open Post Detail (id=42)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // voltar para login (exemplo de logout)
                context.go(AppRoutes.login);
              },
              child: const Text('Logout (Go to Login)'),
            ),
          ],
        ),
      ),
    );
  }
}
