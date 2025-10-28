import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:dev_connect/features/auth/login_page.dart';
import 'package:dev_connect/features/feed/feed_page.dart';
import 'package:dev_connect/features/post/post_detail_page.dart';

class AppRoutes {
  // telas de autenticação / fluxo público
  static const String login = '/login';

  // tela principal com feed
  static const String feed = '/feed';

  // rota com parâmetro (use seu sistema de roteamento para substituir :id)
  static const String postDetail = '/post/:id';
}

/// Nomes das rotas usados pelo GoRouter (valores curtos, reutilizáveis).
class RouteNames {
  static const String login = 'login';
  static const String feed = 'feed';
  static const String postDetail = 'postDetail';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.login,
      name: RouteNames.login,
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.feed,
      name: RouteNames.feed,
      builder: (BuildContext context, GoRouterState state) => const FeedPage(),
    ),
    GoRoute(
      path: AppRoutes.postDetail,
      name: RouteNames.postDetail,
      builder: (BuildContext context, GoRouterState state) {
        final String postId = state.pathParameters['id']!;
        return PostDetailPage(postId: postId);
      },
    ),
  ],
  // redirect: (context, state) {
  //   const bool isLoggedIn = false;
  //   final loggingIn = state.matchedLocation == AppRoutes.login;

  //   if (!isLoggedIn && !loggingIn) return AppRoutes.login;
  //   if (isLoggedIn && loggingIn) return AppRoutes.feed;
  //   return null;
  // },
);
