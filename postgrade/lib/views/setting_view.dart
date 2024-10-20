import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/styles/custom_app_bar.dart';

class SettingPage extends StatefulWidget {
  final String userId;

  const SettingPage({super.key, required this.userId});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String profileImageUrl =
      'https://via.placeholder.com/150'; // デフォルトのプロフィール画像URL

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid; // 現在のユーザーIDを取得

    if (userId != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        _userNameController.text = userDoc['userName'] ?? '';
        _emailController.text = userDoc['email'] ?? '';

        // プロフィール画像のURLを取得
        profileImageUrl = userDoc['profileImageUrl'] ?? profileImageUrl;
      }
    }
  }

  Future<void> _saveProfileSettings() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .update({
      'userName': _userNameController.text.trim(),
      'email': _emailController.text.trim(),
    });

    GoRouter.of(context).go('/'); // ホームページにリダイレクト
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileImage(),
              const SizedBox(height: 16),
              _buildTextField(_userNameController, 'ユーザーネーム'),
              _buildTextField(_emailController, 'メールアドレス'),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    // プロフィール画像の表示
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(profileImageUrl),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    // テキストフィールドのビルダー
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildSaveButton() {
    // 保存ボタンのビルダー
    return ElevatedButton(
      onPressed: _saveProfileSettings,
      child: const Text('保存'),
    );
  }
}
