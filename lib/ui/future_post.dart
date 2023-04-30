import 'package:api_example/repository/post_future.dart';
import 'package:api_example/repository/post_notifier.dart';
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
                    return ListTile(
                      title: Text(posts[index].name), // Postのnameプロパティを表示
                      subtitle: Text(posts[index].createdAt.toIso8601String()), // PostのcreatedAtプロパティを表示
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
