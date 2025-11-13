import 'package:dev_connect/core/di/service_locator.dart';
import 'package:dev_connect/core/routes/app_routes.dart';
import 'package:dev_connect/core/ui/components/loading/dc_loading.dart';
import 'package:dev_connect/core/ui/components/post/image_post.dart';
import 'package:dev_connect/core/ui/components/post/post_timestamp.dart';
import 'package:dev_connect/core/ui/theme/app_colors.dart';
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
    final relativeHeight = MediaQuery.of(context).size.height * 0.75;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        context.pop(_edited);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Observer(builder: (_) {
            return const Text('Detalhes do Post');
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ImagePost(
                  height: relativeHeight,
                  radius: 0,
                  authorImageBytes: _store.post!.authorImageBytes,
                  title: _store.post!.author,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12)
                          .copyWith(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: <Widget>[
                              const Icon(Icons.favorite,
                                  size: 18, color: AppColors.error),
                              const SizedBox(width: 6),
                              Text(_store.post!.likes.toString()),
                              const SizedBox(width: 12),
                              Text(
                                _store.post!.content,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          PostTimestamp(
                            createdAt: _store.post!.createdAt,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
