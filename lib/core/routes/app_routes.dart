import 'package:dev_connect/features/upsert/upsert_post_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:dev_connect/features/auth/login_page.dart';
import 'package:dev_connect/features/feed/feed_page.dart';
import 'package:dev_connect/features/post_detail/post_detail_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String feed = '/feed';
  static const String postDetail = '/post/:id';
  static const String postUpsert = '/post/upsert';
}

class RouteNames {
  static const String login = 'login';
  static const String feed = 'feed';
  static const String postDetail = 'postDetail';
  static const String postUpsert = 'postUpsert';
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
      path: AppRoutes.postUpsert,
      name: RouteNames.postUpsert,
      builder: (BuildContext context, GoRouterState state) {
        final String? id = state.extra is String ? state.extra as String : null;
        return UpsertPostPage(postId: id);
      },
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
);
