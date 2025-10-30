import 'package:dev_connect/services/post_service.dart';
import 'package:dev_connect/features/upsert/store/upsert_post_store.dart';
import 'package:dev_connect/models/post_model.dart';

class UpsertPostController {
  final PostService service;
  final UpsertPostStore store;

  UpsertPostController(this.service, this.store);

  Future<void> loadForEdit(String id) async {
    store.setLoading(true);
    store.clearError();
    try {
      final Post? found = await service.fetchPostById(id);

      store.setCurrentPost(found);
      if (found == null) {
        store.setError('Post não encontrado.');
      }
    } catch (_) {
      store.setError('Não foi possível carregar os dados do post.');
    } finally {
      store.setLoading(false);
    }
  }

  Future<bool> upsertPost(Post post) async {
    store.setSubmitting(true);
    try {
      if (post.id.isNotEmpty) {
        await service.updatePost(post);
      } else {
        await service.savePost(post);
      }
      store.clearError();
      return true;
    } catch (_) {
      store.setError('Não foi possível salvar o post.');
      return false;
    } finally {
      store.setSubmitting(false);
    }
  }
}
