# api_example

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