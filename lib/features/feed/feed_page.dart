import 'package:dev_connect/core/ui/components/post/post_card.dart';
import 'package:dev_connect/core/ui/helpers/snackbar_helper.dart';
import 'package:dev_connect/core/ui/components/loading/dc_loading.dart';
import 'package:dev_connect/features/feed/store/feed_store.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_connect/core/di/service_locator.dart';
import 'package:dev_connect/features/feed/controller/feed_controller.dart';
import 'package:mobx/mobx.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final FeedController _controller = locator<FeedController>();
  ReactionDisposer? _errorDisposer;

  @override
  void initState() {
    super.initState();
    _controller.init();

    _errorDisposer = reaction<String?>((_) => _controller.store.errorMessage, (String? msg) {
      if (msg != null && msg.isNotEmpty) {
        SnackBarHelper.showError(context, msg);
        _controller.store.clearError();
      }
    });
  }

  @override
  void dispose() {
    _errorDisposer?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final FeedStore store = _controller.store;
          if (store.loading) {
            return const DCLoading();
          }

          return ListView.builder(
            itemCount: store.posts.length,
            itemBuilder: (BuildContext context, int index) {
              final Post post = store.posts[index];
              return PostCard(
                post: post,
                onLike: () => _controller.toggleLike(post),
                onComment: () {},
              );
            },
          );
        },
      ),
    );
  }
}
