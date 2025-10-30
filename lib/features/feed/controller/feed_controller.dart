import 'package:dev_connect/features/feed/store/feed_store.dart';
import 'package:dev_connect/core/services/post_service.dart';
import 'package:dev_connect/models/post_model.dart';

class FeedController {
  final FeedStore store;
  final PostService service;

  FeedController(this.store, this.service);

  Future<void> init() async {
    final List<Post> cached = await service.getCachedPosts();
    await store.loadPosts(cached);

    store.setLoading(true);
    try {
      final List<Post> refreshed = await service.fetchAndCachePosts();
      if (refreshed.isNotEmpty) {
        await store.loadPosts(refreshed);
      }
      store.clearError();
    } catch (e) {
      store.setError('Falha ao atualizar o feed.');
    } finally {
      store.setLoading(false);
    }
  }

  Future<void> toggleLike(Post post) async {
    store.toggleLike(post);
    try {
      await service.updatePost(post);
      store.clearError();
    } catch (_) {
      store.toggleLike(post);
      store.setError('Não foi possível atualizar o like.');
    }
  }
}
