import 'package:dev_connect/features/feed/store/feed_store.dart';
import 'package:dev_connect/core/services/post_service.dart';
import 'package:dev_connect/models/post_model.dart';

class FeedController {
  final FeedStore store;
  final PostService service;

  FeedController(this.store, this.service);

  Future<void> init() async {
    store.setLoading(true);
    await Future.delayed(const Duration(milliseconds: 300));
    final List<Post> cached = await service.getCachedPosts();
    await store.loadPosts(cached);
  

    try {
      final bool hasUpdates = store.lastSync != null
          ? await service.shouldUpdate(store.lastSync!)
          : true;

      if (hasUpdates) {
        final List<Post> refreshed = await service.fetchAndCachePosts();
        if (refreshed.isNotEmpty) {
          await store.loadPosts(refreshed);
          store.setLastSync(DateTime.now());
        }
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
      final Map<String, dynamic>? result =
          await service.updateLike(post.id, !post.isLiked);

      if (result != null) {
        final int remoteLikes = result['likes'] as int;
        final bool remoteIsLiked = result['isLiked'] as bool;
        store.syncLike(post.id, remoteLikes, remoteIsLiked);
      }
      store.clearError();
    } catch (_) {
      store.revertLike(post);
      store.setError('Não foi possível atualizar o like.');
    }
  }
}
