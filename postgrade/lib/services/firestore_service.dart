import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 新しい投稿をFirestoreに追加するメソッド
  Future<void> addPost(Post post) async {
    await _db.collection('posts').add(post.toJson());
  }

  // 投稿一覧を取得するメソッド
  Future<List<Post>> fetchPosts() async {
    QuerySnapshot snapshot = await _db.collection('posts').get();
    return snapshot.docs.map((doc) {
      return Post.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // 特定の投稿を取得するメソッド
  Future<Post?> getPost(String id) async {
    DocumentSnapshot doc = await _db.collection('posts').doc(id).get();
    if (doc.exists) {
      return Post.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
