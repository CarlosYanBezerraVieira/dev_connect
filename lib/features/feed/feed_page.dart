import 'package:dev_connect/core/ui/components/post/post_card.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_connect/core/di/service_locator.dart';
import 'package:dev_connect/features/feed/controller/feed_controller.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final FeedController _controller = locator<FeedController>();

  @override
  void initState() {
    super.initState();
    _controller.init();
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
        builder: (_) => ListView.builder(
          itemCount: _controller.store.posts.length,
          itemBuilder: (BuildContext context, int index) {
            final Post post = _controller.store.posts[index];
            return PostCard(
              post: post,
              onLike: () => _controller.toggleLike(post),
              onComment: () {},
            );
          },
        ),
      ),
    );
  }
}
