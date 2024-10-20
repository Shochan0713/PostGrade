import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/views/common/common_utils.dart';

/// クラス名：LoginPageクラス
/// 詳細： ユーザーがFirebase Authenticationを使用して、メールアドレスとパスワードでログインするためのページです。
/// その他： なし
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

/// クラス名：_LoginPageStateクラス
/// 詳細： `_LoginPageState`は`LoginPage`の状態管理を担当します。
/// その他： このクラスには、ログイン処理、エラーメッセージの表示、
/// Firebase Authenticationへのリクエスト送信、
/// ユーザー入力の処理が含まれます。
class _LoginPageState extends State<LoginPage> {
  /// Firebaseの認証インスタンス
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// メールアドレス入力用のTextEditingController
  final TextEditingController _emailController = TextEditingController();

  /// パスワード入力用のTextEditingController
  final TextEditingController _passwordController = TextEditingController();

  /// ローディング状態を管理するフラグ
  bool _isLoading = false;

  /// エラーメッセージを格納する変数
  String? _errorMessage;

  /// パスワードの表示/非表示を管理する変数
  bool _isPasswordVisible = false;

  /// メソッド名：_loginWithEmailAndPassword
  /// 詳細： Firebase Authenticationを使用して、メールアドレスとパスワードでログインします。
  /// その他： ログインが成功した場合、ホーム画面（'/'）に遷移します。
  /// エラーが発生した場合は、エラーメッセージを表示します。
  Future<void> _loginWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    // Firebase Authにログインを試みる
    try {
      //
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        // ログイン成功した場合の処理
        // ignore: use_build_context_synchronously
        GoRouter.of(context).replace('/');
      }
    } on FirebaseAuthException catch (e) {
      // Firebaseのエラー発生時にエラーメッセージを表示
      // ログイン失敗時にエラーログを出力
      setState(() {
        _errorMessage = "メールアドレスもしくはパスワードが正しくありません。";
        debugPrint(e.message);
      });
    } finally {
      // ローディング状態を解除
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// メソッド名：_togglePasswordVisibility
  /// 詳細： _isPasswordVisibleを表示/非表示の設定を行う。
  /// その他： なし
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // 画面生成
  @override
  Widget build(BuildContext context) {
    debugPrint("ログインページ");
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
                Icon(Icons.lock_outline, size: 80, color: Colors.blueGrey[600]),
                const SizedBox(height: 40),
                const Text(
                  'ログイン',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
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
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )),
                const SizedBox(height: 30),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 10),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _loginWithEmailAndPassword,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'ログイン',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    // パスワードを忘れた場合の処理
                  },
                  child: Text(
                    'パスワードを忘れた場合',
                    style: TextStyle(color: Colors.blueGrey[600]),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    debugPrint("サインアップ");
                    GoRouter.of(context).go('/signup');
                  },
                  child: Text(
                    'アカウントを持っていない場合',
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
