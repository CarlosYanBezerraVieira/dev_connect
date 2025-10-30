import 'package:dev_connect/models/post_model.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts();
  Future<Post?> createPost(Post post);
  Future<Post?> updatePost(Post post);
  Future<bool> deletePost(String id);
}
