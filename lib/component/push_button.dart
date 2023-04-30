import 'package:flutter/material.dart';
/// [コンポーネント化した画面遷移用のボタン]
/// ボタンを部品化しておくことで、画面遷移のコードを短くしたり、
/// 使い回すことで、同じコードを書かなくもすむようになる。
class PushButton extends StatelessWidget {
  const PushButton({
    super.key,
    required this.buttonTitle,
    required this.pageName,
  });

  final String buttonTitle; // ボタンのタイトルを引数として渡す
  final Widget pageName; // 画面遷移先のWidgetクラスを引数として渡す

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => pageName));
        },
        child: Text(buttonTitle));
  }
}