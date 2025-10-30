import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:dev_connect/features/auth/login_page.dart';
import 'package:dev_connect/features/feed/feed_page.dart';
import 'package:dev_connect/features/post/post_detail_page.dart';
import 'package:dev_connect/features/post/upsert_post_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String feed = '/feed';
  static const String postDetail = '/post/:id';
  static const String postUpsert = '/post/create';
}

class RouteNames {
  static const String login = 'login';
  static const String feed = 'feed';
  static const String postDetail = 'postDetail';
  static const String postCreate = 'postCreate';
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
    GoRoute(
      path: AppRoutes.postUpsert,
      name: RouteNames.postCreate,
      builder: (BuildContext context, GoRouterState state) {
        final String? id = state.extra is String ? state.extra as String : null;
        return UpsertPostPage(postId: id);
      },
    ),
  ],
);
