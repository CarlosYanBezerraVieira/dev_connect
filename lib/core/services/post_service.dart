import 'package:dev_connect/models/post_model.dart';

abstract class PostService {
  Future<List<Post>> getCachedPosts();
  Future<List<Post>> fetchAndCachePosts();
  Future<void> savePost(Post post);
  Future<void> updatePost(Post post);
  Future<void> deletePost(String id);
}
