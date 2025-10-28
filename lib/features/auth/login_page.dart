import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dev_connect/core/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // navegar para o feed
            context.go(AppRoutes.feed);
          },
          child: const Text('Go to Feed'),
        ),
      ),
    );
  }
}
