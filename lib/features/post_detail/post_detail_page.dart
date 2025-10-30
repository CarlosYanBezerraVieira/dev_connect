import 'package:dev_connect/core/di/service_locator.dart';
import 'package:dev_connect/core/routes/app_routes.dart';
import 'package:dev_connect/core/ui/components/loading/dc_loading.dart';
import 'package:dev_connect/core/ui/components/post/post_header.dart';
import 'package:dev_connect/features/post_detail/controller/post_detail_controller.dart';
import 'package:dev_connect/features/post_detail/store/post_detail_store.dart';
import 'package:dev_connect/core/ui/dialog/delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool _edited = false;
  PostDetailController get _controller => locator<PostDetailController>();
  PostDetailStore get _store => _controller.store;

  @override
  void initState() {
    super.initState();
    _controller.load(widget.postId);
  }

  Future<void> _edit() async {
    if (_store.post == null) return;
    final bool? ok = await context.push<bool>(
      AppRoutes.postUpsert,
      extra: widget.postId,
    );
    if (ok == true) {
      _edited = true;
      await _controller.load(widget.postId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post atualizado.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        context.pop(_edited);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Observer(builder: (_) {
            final String title = (_store.post?.author.isNotEmpty == true)
                ? _store.post!.author
                : 'Detalhes do Post';
            return Text(title);
          }),
          actions: <Widget>[
            Observer(builder: (_) {
              if (_store.post == null) return const SizedBox.shrink();
              return Row(children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _edit,
                  tooltip: 'Editar',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    final bool? confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => const DeleteConfirmationDialog(),
                    );
                    if (confirm == true) {
                      final bool ok =
                          await _controller.removePost(widget.postId);
                      if (ok && mounted) {
                        // ignore: use_build_context_synchronously
                        context.pop(true);
                      }
                    }
                  },
                  tooltip: 'Remover',
                ),
              ]);
            }),
          ],
        ),
        body: Observer(builder: (_) {
          if (_store.loading) {
            return const Center(child: DCLoading());
          }
          if (_store.errorMessage != null) {
            return Center(child: Text(_store.errorMessage!));
          }
          if (_store.post == null) {
            return const Center(child: Text('Post não encontrado.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PostHeader(
                  author: _store.post!.author,
                  authorImageBytes: _store.post!.authorImageBytes,
                  createdAt: _store.post!.createdAt,
                ),
                const SizedBox(height: 12),
                Text(
                  _store.post!.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up,
                        size: 18, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 6),
                    Text('${_store.post!.likes} curtidas'),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
