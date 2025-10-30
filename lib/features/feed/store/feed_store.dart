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

  @observable
  DateTime? lastSync;

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
    final bool newIsLiked = !current.isLiked;
    final int newLikes = newIsLiked ? current.likes + 1 : current.likes - 1;
    posts[index] = current.copyWith(likes: newLikes, isLiked: newIsLiked);
  }

  @action
  void revertLike(Post post) {
    final int index = posts.indexWhere((Post p) => p.id == post.id);
    if (index == -1) return;

    posts[index] = post;
  }

  @action
  void syncLike(String postId, int likes, bool isLiked) {
    final int index = posts.indexWhere((Post p) => p.id == postId);
    if (index == -1) return;
    final Post current = posts[index];
    posts[index] = current.copyWith(likes: likes, isLiked: isLiked);
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

  @action
  void setLastSync(DateTime? dateTime) {
    lastSync = dateTime;
  }
}
