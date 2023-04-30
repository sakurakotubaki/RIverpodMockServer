import 'package:api_example/model/post.dart';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

/// [Postを型に使いモックサーバーからデータを取得する関数.]
List<Post> parsePost(String responseBody) {
  // 引数をキャストしてMap型に変換
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
  // 配列をmapメソッドでループさせる。
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

// インターネットからデータを取得するメソッド
Future<List<Post>> fetchPosts() async {
  const endpoint = 'http://localhost:3000/posts';
  final url = Uri.parse(endpoint);

  var response = await http.get(url);
  if (response.statusCode == 200) {
    // ステータスコードを表示する
    print('ステータスコード: ${response.statusCode}');
    // JSONのデータを表示する
    print('JSONのデータ:  ${response.body}');
    return compute(parsePost, response.body);
  } else {
    throw Exception('Failed to load book');
  }
}

// 自動でデータを再取得するよう設定するFutureProvider.
final postsProvider = FutureProvider<List<Post>>((ref) async {
  return fetchPosts();
});
