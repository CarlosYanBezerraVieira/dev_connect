import 'package:dev_connect/models/post_model.dart';
import 'package:mobx/mobx.dart';

part 'post_detail_store.g.dart';

// ignore: library_private_types_in_public_api
class PostDetailStore = _PostDetailStore with _$PostDetailStore;

abstract class _PostDetailStore with Store {
  @observable
  bool loading = true;

  @observable
  String? errorMessage;

  @observable
  Post? post;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setError(String? message) => errorMessage = message;

  @action
  void setPost(Post? value) => post = value;

  @action
  void clearError() => errorMessage = null;
}
