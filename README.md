# api_example

- 開発環境
  - Mac OS Ventura
  - Flutter 3.7.8
  - Dart 2.19.5
  - flutter_riverpod
  - http
  - Freezed

## flutter_riverpod
flutter_riverpodのパッケージを追加する
```
flutter pub add flutter_riverpod
```

## http package
FlutterでHTTP通信を行うのに必要なパッケージを追加
```
flutter pub add http
```

## Freezed
Freezedを使用するために必要なパッケージを追加する
```
flutter pub add freezed_annotation
flutter pub add build_runner --dev
flutter pub add freezed --dev
flutter pub add json_serializable --dev
flutter pub add json_annotation
```
ファイルを自動生成するコマンド
```
flutter pub run build_runner watch --delete-conflicting-outputs
```

## 設計について
同じコードを書かなくて済むように、画面遷移用のボタンは部品化して、componentディレクトリに作成しました。
モックサーバーのデータ型を定義したPostモデルクラスは、modelディレクトリに作成しました。Freezedを使用することで、toJson,fromJSONを自分で書く必要がなくなり、設定をすればコードを自動生成してくれるので、コードを書く量を減らすことができます。
HTTP通信をおこなって、APIとやりとりをするロジックが書いてあるファイルは、repositoryディレクトリに作成しました。
アプリの画面として使用するファイルは、uiディレクトリに作成いたしました。追加ページ、データを一度だけネットワークから取得するページ、データが変更されたら、画面が更新されるページ、表示されているAPIのデータをタップすると、詳細ページへ移動して、編集ができるページ、ゴミ箱のボタンを押すとデータを削除するメソッドが実行される画面を作成いたしました。

**ディレクトリの構造**
```
lib/
├── component
│   └── push_button.dart
├── main.dart
├── model
│   ├── post.dart
│   ├── post.freezed.dart
│   └── post.g.dart
├── repository
│   ├── post_future.dart
│   └── post_notifier.dart
└── ui
    ├── add_post.dart
    ├── edit_post.dart
    ├── future_post.dart
    ├── home_page.dart
    └── post_list.dart
```

## モックサーバーを使う方法
git cloneした場合は、Node.jsがインストールされていれば、mock-apiディレクトリに移動して、npmのコマンドを実行すれば、必要なパッケージをインストールして、環境構築を自動で行なってくれます。

```
cd mock-api
npm install
```
新しくモックサーバーを作成する場合は、mock-apiディレクトリのREADME.mdに書いてある解説を読んで、環境構築を行なってください。