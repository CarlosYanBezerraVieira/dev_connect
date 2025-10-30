import 'package:dev_connect/models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts();
  Future<Post?> fetchPostById(String id);
  Future<Post?> createPost(Post post);
  Future<Post?> updatePost(Post post);
  Future<bool> deletePost(String id);
  Future<Map<String, dynamic>?> patchLike(String id, bool isLiked);
  Future<bool> shouldUpdate(DateTime lastSync);
}
