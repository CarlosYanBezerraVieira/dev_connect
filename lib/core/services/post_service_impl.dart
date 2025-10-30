import 'package:dev_connect/core/db/hive_local_storage_service.dart';
import 'package:dev_connect/repositories/post_repository.dart';
import 'package:dev_connect/core/services/post_service.dart';
import 'package:dev_connect/models/post_model.dart';

class PostServiceImpl implements PostService {
  final PostRepository api;
  final HiveLocalStorageService<Post> local;

  PostServiceImpl(this.api, this.local);

  @override
  Future<List<Post>> getCachedPosts() async {
    return await local.getAll();
  }

  @override
  Future<List<Post>> fetchAndCachePosts() async {
    final List<Post> remote = await api.fetchPosts();
    if (remote.isNotEmpty) {
      await local.clear();
      for (final Post p in remote) {
        await local.put(p.id, p);
      }
    }
    return await local.getAll();
  }

  @override
  Future<void> savePost(Post post) async {
    await api.createPost(post);
  }

  @override
  Future<void> updatePost(Post post) async {
    await api.updatePost(post);
  }

  @override
  Future<void> deletePost(String id) async {
    await api.deletePost(id);
  }
}
