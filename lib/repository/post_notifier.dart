import 'dart:convert';
import 'package:api_example/model/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final apiProvider = StateNotifierProvider<ApiNotifier, ApiState>((ref) {
  return ApiNotifier();
});

class ApiState {
  final List<Post> data;
  final String error;

  ApiState({required this.data, required this.error});
}

class ApiNotifier extends StateNotifier<ApiState> {
  ApiNotifier() : super(ApiState(data: [], error: ''));

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Post> posts =
            jsonData.map((json) => Post.fromJson(json)).toList();
        state = ApiState(data: posts, error: '');
      } else {
        state = ApiState(data: [], error: 'Error: ${response.statusCode}');
      }
    } catch (e) {
      state = ApiState(data: [], error: 'Error: $e');
    }
  }

  Future<void> postData(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode == 201) {
        fetchData(); // 更新されたデータを取得します。
      } else {
        state = ApiState(data: [], error: 'Error: ${response.statusCode}');
      }
    } catch (e) {
      state = ApiState(data: [], error: 'Error: $e');
    }
  }

  // データを更新するメソッド
  Future<void> updateData(Post updatedPost) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/posts/${updatedPost.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedPost.toJson()),
      );
      if (response.statusCode == 200) {
        fetchData(); // 更新されたデータを取得します。
      } else {
        state = ApiState(data: [], error: 'Error: ${response.statusCode}');
      }
    } catch (e) {
      state = ApiState(data: [], error: 'Error: $e');
    }
  }

  // データを削除するメソッド
Future<void> deleteData(String postId) async {
  try {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/posts/$postId'),
    );
    if (response.statusCode == 200) {
      fetchData(); // 更新されたデータを取得します。
    } else {
      state = ApiState(data: [], error: 'Error: ${response.statusCode}');
    }
  } catch (e) {
    state = ApiState(data: [], error: 'Error: $e');
  }
}

}

final postProvider = StateNotifierProvider<ApiNotifier, ApiState>((ref) {
  return ApiNotifier();
});
