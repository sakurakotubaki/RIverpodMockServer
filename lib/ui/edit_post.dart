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

class UpdatePost extends ConsumerWidget {
  const UpdatePost({super.key});

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
                  final updatedPost = Post(
                    id: idController.text,
                    name: nameController.text,
                    createdAt: DateTime.now(),
                  );
                  ref.read(apiProvider.notifier).updateData(updatedPost);
                },
                child: const Text('更新')),
          ],
        ),
      ),
    );
  }
}
