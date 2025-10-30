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
    final List<Post> refreshed = await service.fetchAndCachePosts();
    store.setLoading(false);

    if (refreshed.isNotEmpty) {
      await store.loadPosts(refreshed);
    }
  }

  void toggleLike(Post post) {
    store.toggleLike(post);
    service.updatePost(post);
  }

  void addPost(Post post) {
    store.addPost(post);
    service.savePost(post);
  }

  void removePost(String id) {
    store.removePost(id);
    service.deletePost(id);
  }
}