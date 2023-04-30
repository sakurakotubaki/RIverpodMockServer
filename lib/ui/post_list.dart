import 'package:api_example/component/push_button.dart';
import 'package:api_example/model/post.dart';
import 'package:api_example/repository/post_notifier.dart';
import 'package:api_example/ui/edit_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/// [リアルタイムデータが更新されるページ]
/// データが変更されると、画面に表示されているリストの内容がすぐに変わる
class PostListView extends ConsumerWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(apiProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: PostsList(),
    );
  }
}

class PostsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiState = ref.watch(apiProvider);

    // 初期データの取得
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(apiProvider.notifier).fetchData();
    });

    if (apiState.data.isNotEmpty) {
      return ListView.builder(
        itemCount: apiState.data.length,
        itemBuilder: (context, index) {
          final post = apiState.data[index];
          return ListTile(
            // リストをタップすると詳細ページへ移動する
            onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePost(posts: post)));
                    },
            title: Text(post.name),
            subtitle: Text('Created at: ${post.createdAt}'),
            trailing: IconButton(
                onPressed: () {
                  ref.read(apiProvider.notifier).deleteData(post.id);
                },
                icon: const Icon(Icons.delete)),
          );
        },
      );
    } else if (apiState.error.isNotEmpty) {
      return Center(child: Text('500 Error: ${apiState.error}'));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
