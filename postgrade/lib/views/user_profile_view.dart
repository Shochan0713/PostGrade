import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Firestoreからユーザー情報を取得
  Future<Map<String, dynamic>?> _getUserData(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.exists ? userDoc.data() as Map<String, dynamic>? : null;
  }

  @override
  Widget build(BuildContext context) {
    // 現在のユーザーIDを取得
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        // userIdを引数に
        future: userId != null ? _getUserData(userId) : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('エラーが発生しました')),
                TextButton(
                  onPressed: () {
                    _logout(context);
                    GoRouter.of(context).replace('/login');
                  },
                  child: Text('ログイン画面へ'),
                ),
              ],
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('ユーザーデータが見つかりません'));
          }

          // Firestoreから取得したユーザー情報
          String userName = snapshot.data!['userName'] ?? 'User Name';
          String email = snapshot.data!['email'] ?? 'user@example.com';
          String profileImageUrl = snapshot.data!['profileImageUrl'] ??
              'https://via.placeholder.com/150';

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // プロフィール編集やログアウト機能の実装
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: _bottomNavBar,
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // ログアウト後のリダイレクト
      GoRouter.of(context).go('/login'); // ログインページにリダイレクト
    } catch (e) {
      // エラーハンドリング
      print('Logout error: $e');
    }
  }
}
