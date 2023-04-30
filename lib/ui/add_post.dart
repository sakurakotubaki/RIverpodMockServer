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
/// [モックサーバーにデータを追加するページ]
class AddPost extends ConsumerWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idController = ref.watch(idProvider);
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
                controller: idController,
                // キーボードのタイプを数字にする
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // 文字数を制限できる
                  LengthLimitingTextInputFormatter(16),
                  // 数字のみしか入力させないようにする
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                  controller: nameController,
                )),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  final newPost = Post(
                    id: idController.text,
                    name: nameController.text,
                    createdAt: DateTime.now(),
                  );
                  ref.read(apiProvider.notifier).postData(newPost);
                  // clearメソッドを使用すると、入力フォームに残っていまうテキストを消すことができる。
                  // 消さないと、他の入力ページで出てくることがある。
                  idController.clear();
                  nameController.clear();
                },
                child: const Text('新規作成'))
          ],
        ),
      ),
    );
  }
}
