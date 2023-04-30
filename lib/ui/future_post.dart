import 'package:api_example/component/push_button.dart';
import 'package:api_example/repository/post_future.dart';
import 'package:api_example/repository/post_notifier.dart';
import 'package:api_example/ui/edit_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuturePost extends ConsumerWidget {
  const FuturePost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Center(
        child: value.when(
            data: (posts) {
              return ListView.builder(
                // 配列のデータを描画するWidget
                itemCount: posts.length, // 配列の数をカウント
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    // リストをタップすると詳細ページへ移動する
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePost(posts: post)));
                    },
                    title: Text(post.name), // Postのnameプロパティを表示
                    subtitle: Text(post.createdAt
                        .toIso8601String()), // PostのcreatedAtプロパティを表示
                  );
                },
              );
            },
            // データが習得できなかったら、ローディングされる.
            error: (err, stack) => Center(child: Text(err.toString())),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
