import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerUser(
    String email, String password, String userName) async {
  try {
    // 1. Firebase Authenticationにユーザーを登録
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2. Firestoreにユーザー情報を保存
    User? user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'userName': userName,
        'email': email,
        'profileImageUrl': 'https://via.placeholder.com/150', // デフォルト画像
      });
    }
  } catch (e) {
    print('Registration error: $e');
  }
}
