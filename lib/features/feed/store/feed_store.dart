import 'package:mobx/mobx.dart';
import 'package:dev_connect/models/post_model.dart';

part 'feed_store.g.dart';

// ignore: library_private_types_in_public_api
class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  _FeedStoreBase() {
    posts = ObservableList<Post>();
  }

  @observable
  ObservableList<Post> posts = ObservableList<Post>();

  @observable
  bool loading = false;

  @observable
  String? errorMessage;

  @action
  void setLoading(bool value) {
    loading = value;
  }

  @action
  Future<void> loadPosts(List<Post> initialPosts) async {
    posts.clear();
    posts.addAll(initialPosts);
  }

  @action
  void setError(String? message) {
    errorMessage = message;
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  @action
  void toggleLike(Post post) {
    final int index = posts.indexWhere((Post p) => p.id == post.id);
    if (index == -1) return;

    final Post current = posts[index];
    current.isLiked = !current.isLiked;
    if (current.isLiked) {
      current.likes++;
    } else {
      current.likes--;
    }
    posts[index] = current;
  }

  @action
  void addPost(Post post) {
    posts.insert(0, post);
  }

  @action
  void insertPostAtIndex(Post post, int index) {
    if (index < 0 || index > posts.length) {
      posts.add(post);
    } else {
      posts.insert(index, post);
    }
  }

  @action
  void removePost(String id) {
    posts.removeWhere((Post p) => p.id == id);
  }
}
