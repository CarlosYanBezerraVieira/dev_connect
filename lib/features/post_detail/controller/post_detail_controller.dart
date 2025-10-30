import 'package:dev_connect/core/services/post_service.dart';
import 'package:dev_connect/features/post_detail/store/post_detail_store.dart';
import 'package:dev_connect/models/post_model.dart';

class PostDetailController {
  final PostService service;
  final PostDetailStore store;

  PostDetailController(this.service, this.store);

  Future<void> load(String id) async {
    store.setLoading(true);
    store.clearError();
    try {
      Post? found;

      final List<Post> afterRemote = await service.fetchAndCachePosts();
      found = afterRemote.firstWhere(
        (Post p) => p.id == id,
        orElse: () => Post(
          id: '',
          author: '',
          authorImageBytes: '',
          content: '',
          likes: 0,
          isLiked: false,
        ),
      );
      if (found.id.isEmpty) {
        found = null;
      }

      store.setPost(found);
      if (found == null) {
        store.setError('Post não encontrado.');
      }
    } catch (_) {
      store.setError('Não foi possível carregar o post.');
    } finally {
      store.setLoading(false);
    }
  }

  Future<bool> removePost(String id) async {
    store.setLoading(true);
    store.clearError();
    try {
      await service.deletePost(id);
      store.setPost(null);
      return true;
    } catch (_) {
      store.setError('Não foi possível remover o post.');
      return false;
    } finally {
      store.setLoading(false);
    }
  }
}
