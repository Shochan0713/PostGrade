import 'package:flutter/material.dart';

class CommonUtils {
  /// メソッド名：buildTextField
  /// 詳細： テキストフィールドうジェットを作成します。
  /// その他： [controller]はテキスト入力を制御し、[hintText]はフィールドのプレースホルダーです。
  /// [icon]はフィールドのアイコンであり、[obscureText]がtrueの場合はパスワード入力用になります。
  ///
  /// @param controller テキスト入力の制御
  /// @param hintText フィールドのプレースホルダー
  /// @param icon フィールドのアイコン
  /// @param obscureText trueの場合はパスワード入力用
  /// @param suffixIcon パスワード表示切替用のアイコンボタン
  static Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blueGrey[600]),
        suffixIcon: suffixIcon, // アイコンボタンを受け取る
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      ),
    );
  }
}
