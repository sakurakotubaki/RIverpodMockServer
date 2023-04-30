import 'package:api_example/model/post.dart';
import 'package:api_example/repository/post_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final idProvider = StateProvider((ref) {
  return TextEditingController();
});

final nameProvider = StateProvider((ref) {
  return TextEditingController();
});
/// [モックサーバーのデータを編集するページ]
/// 前のページから、Postモデルクラスの値を受け取ることができるので、
/// idを入力フォームから、直接入力しなくてもid1,id2と指定できる。
class UpdatePost extends ConsumerWidget {
  // ListView.builderから値を受け取れるように、コンストラクターを定義する
  // {super.key, required this.posts}の書き方でないと、前のページから値を受け取れない
  const UpdatePost({super.key, required this.posts});
  // 受け取った値を保存する変数を作る
  final Post posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 300,
                child: TextFormField(
                  controller: nameController,
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  final updatedPost = Post(
                    id: posts.id,// 前のページから渡されたリストのidを使用
                    name: nameController.text,
                    createdAt: DateTime.now(),
                  );
                  ref.read(apiProvider.notifier).updateData(updatedPost);
                  nameController.clear();
                },
                child: const Text('更新')),
          ],
        ),
      ),
    );
  }
}
