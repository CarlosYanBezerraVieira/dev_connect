import 'package:dev_connect/models/post_model.dart';
import 'package:mobx/mobx.dart';
import 'dart:typed_data';

part 'upsert_post_store.g.dart';

// ignore: library_private_types_in_public_api
class UpsertPostStore = _UpsertPostStore with _$UpsertPostStore;

abstract class _UpsertPostStore with Store {
  @observable
  bool submitting = false;

  @observable
  String? errorMessage;

  @observable
  bool loading = false;

  @observable
  Post? currentPost;

  @observable
  Uint8List? selectedImageBytes;

  @action
  void setSubmitting(bool value) {
    submitting = value;
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
  void setLoading(bool value) {
    loading = value;
  }

  @action
  void setCurrentPost(Post? value) {
    currentPost = value;
  }

  @action
  void setSelectedImageBytes(Uint8List? bytes) {
    selectedImageBytes = bytes;
  }

  @action
  void clearSelectedImageBytes() {
    selectedImageBytes = null;
  }
}
