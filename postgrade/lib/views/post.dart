import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

// Providers
final postTitleProvider = StateProvider<String>((ref) => '');
final postContentProvider = StateProvider<String>((ref) => '');

// FireStoreService
final firestoreServiceProvider = Provider((ref) => FirestoreService());
Future<String> getRatingFromNodeChatAPI(String content) async {
  final url =
      Uri.parse('http://192.168.1.32:3000/ratePost'); // localhostの代わりにPCのIPアドレス
  try {
    final response = await http.post(
      url,
      body: jsonEncode({'content': content}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['rating'];
    } else {
      throw Exception('Failed to get rating from Node.js server');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to connect to Node.js server');
  }
}

Future<String> getRatingFromNode(String content) async {
  print("getRatingFromNodeを実行");
  final url =
      Uri.parse('http://192.168.1.32:3000/ratePost'); // localhostの代わりにPCのIPアドレス
  try {
    final response = await http.post(
      url,
      body: jsonEncode({'content': content}),
      headers: {'Content-Type': 'application/json'},
    );
    print("response post");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['rating']; // ここで評価'A'が返される
    } else {
      print('Error response: ${response.body}'); // ここでレスポンスボディを出力
      throw Exception('Failed to save post on Node.js server');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to connect to Node.js server');
  } finally {
    print('投稿終了');
  }
}

// Post Screen
class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(postContentProvider);
    final firestoreService = ref.read(firestoreServiceProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 4,
              onChanged: (value) {
                ref.read(postContentProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (content.isNotEmpty) {
                  // 現在のユーザーを取得
                  User? currentUser = FirebaseAuth.instance.currentUser;
                  // Node.jsサーバーからratingを取得
                  String rating = await getRatingFromNode(content);
                  if (currentUser != null) {
                    // 新しいPostオブジェクトを作成
                    var newPost = Post(
                      id: const Uuid().v4(),
                      rating: rating,
                      content: content,
                      timestamp: DateTime.now(),
                      userId: currentUser.uid, // ユーザーIDを追加
                    );

                    // Firestoreに投稿を保存
                    print("firestoreService.addPost(newPost)でFirebaseに登録");
                    await firestoreService.addPost(newPost);

                    // 投稿成功のメッセージを表示
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Post submitted!')),
                    );

                    // フィールドをクリア
                    ref.read(postTitleProvider.notifier).state = '';
                    ref.read(postContentProvider.notifier).state = '';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not logged in')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }
}
