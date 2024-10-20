import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    super.initState();
    String? userId = FirebaseAuth.instance.currentUser?.uid; // 現在のユーザーIDを取得
    _loadUserData(userId!);
  }

  Future<void> _loadUserData(String userId) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      _userNameController.text = userDoc['userName'] ?? '';
      _emailController.text = userDoc['email'] ?? '';
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

    GoRouter.of(context).go('/'); // ログインページにリダイレクト
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'ユーザーネーム'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'メールアドレス'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfileSettings,
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
