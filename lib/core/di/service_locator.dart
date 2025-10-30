import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

import 'package:dev_connect/core/network/api_client.dart';
import 'package:dev_connect/core/services/hive_local_storage_service.dart';

import 'package:dev_connect/models/post_model.dart';

import 'package:dev_connect/features/post/repositories/post_repository.dart';
import 'package:dev_connect/features/post/repositories/post_repository_impl.dart';
import 'package:dev_connect/features/post/services/post_service.dart';
import 'package:dev_connect/features/post/services/post_service_impl.dart';

import 'package:dev_connect/features/feed/store/feed_store.dart';
import 'package:dev_connect/features/feed/controller/feed_controller.dart';

import 'package:dev_connect/features/post/store/upsert_post_store.dart';
import 'package:dev_connect/features/post/controller/upsert_post_controller.dart';
import 'package:dev_connect/features/post/store/post_detail_store.dart';
import 'package:dev_connect/features/post/controller/post_detail_controller.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
    final String baseUrl =
            dotenv.env['API_BASE_URL'] ?? 'https://example.com/api';
    final String postsBoxName = dotenv.env['POSTS_BOX_NAME'] ?? 'posts';

    final ApiClient apiClient = ApiClient(baseUrl: baseUrl);
    locator.registerSingleton<ApiClient>(apiClient);

    Hive.registerAdapter(PostAdapter());
    final HiveLocalStorageService<Post> postsLocal =
            HiveLocalStorageService<Post>(postsBoxName);
    await postsLocal.init();
    locator.registerSingleton<HiveLocalStorageService<Post>>(postsLocal);


    locator.registerSingleton<PostRepository>(
        PostRepositoryImpl(locator<ApiClient>()),
    );

    locator.registerSingleton<PostService>(
        PostServiceImpl(
            locator<PostRepository>(),
            locator<HiveLocalStorageService<Post>>(),
        ),
    );


    locator.registerSingleton<FeedStore>(FeedStore());
    locator.registerSingleton<FeedController>(
        FeedController(
            locator<FeedStore>(),
            locator<PostService>(),
        ),
    );

    locator.registerSingleton<UpsertPostStore>(UpsertPostStore());
    locator.registerSingleton<UpsertPostController>(
        UpsertPostController(
            locator<PostService>(),
            locator<UpsertPostStore>(),
        ),
    );

    locator.registerSingleton<PostDetailStore>(PostDetailStore());
    locator.registerSingleton<PostDetailController>(
        PostDetailController(
            locator<PostService>(),
            locator<PostDetailStore>(),
        ),
    );
}
