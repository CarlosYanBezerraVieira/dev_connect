import 'package:dev_connect/models/post_model.dart';

abstract class PostService {
  Future<List<Post>> getCachedPosts();
  Future<List<Post>> fetchAndCachePosts();
  Future<Post?> fetchPostById(String id);
  Future<void> savePost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String id);
  Future<Map<String, dynamic>?> updateLike(String id, bool isLiked);
  Future<bool> shouldUpdate(DateTime lastSync);
}
