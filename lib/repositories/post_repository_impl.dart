import 'dart:developer';
import 'package:dev_connect/core/network/api_client.dart';
import 'package:dev_connect/repositories/post_repository.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiClient _api;

  PostRepositoryImpl(this._api);

  @override
  Future<List<Post>> fetchPosts() async {
    try {
      final Response<dynamic> response = await _api.get('/posts/getAll');
      if (response.statusCode == 200 && response.data != null) {
        final dynamic data = response.data;

        final List<Post> posts = (data as List<dynamic>)
            .map((e) => Post.fromJson(e as Map<String, dynamic>))
            .toList();
        return posts;
      }
    } catch (e) {
      log(e.toString());
    }
    return <Post>[];
  }

  @override
  Future<Post?> fetchPostById(String id) async {
    try {
      final Response<dynamic> response = await _api.get('/posts/$id');
      if (response.statusCode == 200 && response.data != null) {
        return Post.fromJson(response.data as Map<String, dynamic>);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<Post?> createPost(Post post) async {
    try {
      final Response<dynamic> response =
          await _api.post('/posts', data: post.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Post.fromJson(response.data as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<Post?> updatePost(Post post) async {
    try {
      final Response<dynamic> response =
          await _api.put('/posts/${post.id}', data: post.toJson());
      if (response.statusCode == 200 && response.data != null) {
        return Post.fromJson(response.data as Map<String, dynamic>);
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<bool> deletePost(String id) async {
    try {
      final Response<dynamic> response = await _api.delete('/posts/$id');
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (_) {}
    return false;
  }

  @override
  Future<Map<String, dynamic>?> patchLike(String id, bool isLiked) async {
    try {
      final Response<dynamic> response = await _api.patch(
        '/posts/$id/like',
        data: {'isLiked': isLiked},
      );
      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  @override
  Future<bool> shouldUpdate(DateTime lastSync) async {
    try {
      final String isoDate = lastSync.toIso8601String();
      final Response<dynamic> response =
          await _api.get('/posts/shouldUpdate/$isoDate');
      if (response.statusCode == 200 && response.data != null) {
        final dynamic data = response.data;
        return (data as Map<String, dynamic>)['shouldUpdate'] as bool;
      }
    } catch (_) {}
    return true;
  }
}
