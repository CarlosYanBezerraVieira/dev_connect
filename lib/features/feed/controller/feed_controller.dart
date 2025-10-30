import 'package:dev_connect/features/feed/store/feed_store.dart';
import 'package:dev_connect/features/post/services/post_service.dart';
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

  Future<void> addPost(Post post) async {
    store.addPost(post);
    try {
      await service.savePost(post);
      store.clearError();
    } catch (_) {
      store.removePost(post.id);
      store.setError('Não foi possível criar o post.');
    }
  }

  Future<void> removePost(String id) async {
    final int index = store.posts.indexWhere((Post p) => p.id == id);
    Post? removed;
    if (index != -1) {
      removed = store.posts[index];
    }

    store.removePost(id);
    try {
      await service.deletePost(id);
      store.clearError();
    } catch (_) {
      if (removed != null) {
        store.insertPostAtIndex(removed, index);
      }
      store.setError('Não foi possível remover o post.');
    }
  }
}
