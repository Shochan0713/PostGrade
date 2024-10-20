import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/views/common/common_utils.dart';

/// クラス名：SignUpPageクラス
/// 詳細： ユーザーがFirebase Authenticationを使用して、メールアドレスとパスワードを使用してユーザーを登録するためのページです。
/// その他： なし
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

/// クラス名：_SignUpPageStateクラス
/// 詳細： `_SignUpPageStateクラス`は`SignUpPage`の状態管理を担当します。
/// その他： このクラスには、メールアドレス、パスワードを使用し、Firebase Authenticationにユーザーアカウントを登録します。
class _SignUpPageState extends State<SignUpPage> {
  /// Firebaseの認証インスタンス
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// FireStoreのインスタンス
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// メールアドレス入力用のTextEditingController
  final TextEditingController _emailController = TextEditingController();

  /// パスワード入力用のTextEditingController
  final TextEditingController _passwordController = TextEditingController();

  /// パスワード確認入力用のTextEditingController
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// ローディング状態を管理するフラグ
  bool _isLoading = false;

  /// エラーメッセージを格納する変数
  String? _errorMessage;

  /// メソッド名：_signUpWithEmailAndPassword
  /// 詳細： 入力されたメールアドレスを基に、ユーザーをFirebase、FireStoreに登録します。
  /// その他： パスワードと確認用パスワードが一致しているか確認します。メールアドレスと、パスワードを基に、ユーザー登録を行う。
  /// エラーが発生した場合は、エラーメッセージを表示します。
  Future<void> _signUpWithEmailAndPassword() async {
    // パスワードと確認用パスワードが一致していることを確認。
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'パスワードが一致しません';
      });
      return;
    }

    setState(() {
      _isLoading = true; // ローディング中に設定
    });

    // ユーザー登録
    try {
      // Firebase Authenticationを使用して新しいユーザーを作成
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // ユーザーの作成が成功した場合
      if (userCredential.user != null) {
        // Firestoreにユーザー情報を保存
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'userName': 'Default User', // ユーザー名を適宜設定
          'email': _emailController.text.trim(), // メールアドレスをFirestoreに保存

          'profileImageUrl':
              'https://via.placeholder.com/150', // デフォルトのプロフィール画像
        });

        // サインアップ成功後、ホーム画面にリダイレクト
        // ignore: use_build_context_synchronously
        GoRouter.of(context).replace('/');
      }
    } on FirebaseAuthException catch (e) {
      // Firebaseのエラー発生時にエラーメッセージを表示
      setState(() {
        _errorMessage = e.message; // エラーメッセージを設定
      });
    } finally {
      // ローディング状態を解除
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_add, size: 80, color: Colors.blueGrey[600]),
                const SizedBox(height: 40),
                const Text(
                  'サインアップ',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                CommonUtils.buildTextField(
                  controller: _emailController,
                  hintText: 'メールアドレス',
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                CommonUtils.buildTextField(
                  controller: _passwordController,
                  hintText: 'パスワード',
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                CommonUtils.buildTextField(
                  controller: _confirmPasswordController,
                  hintText: 'パスワード確認',
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 10),
                _isLoading
                    ? const CircularProgressIndicator() // ローディングインジケーター
                    : ElevatedButton(
                        onPressed:
                            _signUpWithEmailAndPassword, // サインアップボタンのクリック時の処理
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'サインアップ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go('/login'); // ログインページに遷移
                  },
                  child: Text(
                    'アカウントをお持ちの場合',
                    style: TextStyle(color: Colors.blueGrey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
