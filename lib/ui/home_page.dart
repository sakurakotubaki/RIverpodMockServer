import 'package:api_example/component/push_button.dart';
import 'package:api_example/ui/add_post.dart';
import 'package:api_example/ui/edit_post.dart';
import 'package:api_example/ui/future_post.dart';
import 'package:api_example/ui/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PushButton(buttonTitle: 'データを追加', pageName: const AddPost()),
            PushButton(buttonTitle: '一度だけデータを取得', pageName: const FuturePost()),
            PushButton(buttonTitle: 'リアルタイム', pageName: const PostListView()),
          ],
        ),
      ),
    );
  }
}
