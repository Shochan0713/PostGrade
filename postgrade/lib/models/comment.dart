import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String commentId; // コメントのID
  String postId; // コメントが紐づく投稿のID
  String userId; // コメントをしたユーザーのID
  String content; // コメント内容
  DateTime timestamp; // コメントの作成日時
  String rating; // ChatGPTによるコメントの評価 (例: "A", "B", "C", "D")

  Comment({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.content,
    required this.timestamp,
    required this.rating, // 評価の初期化
  });

  // Firestoreから取得したデータを使ってCommentオブジェクトを生成する
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      postId: json['postId'],
      userId: json['userId'],
      content: json['content'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      rating: json['rating'], // 評価を追加
    );
  }

  // CommentオブジェクトをFirestoreに保存するためにJSON形式に変換
  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'postId': postId,
      'userId': userId,
      'content': content,
      'timestamp': timestamp,
      'rating': rating, // 評価を含めて保存
    };
  }

  // 評価を数値に変換するメソッド
  int getRatingValue() {
    switch (rating) {
      case 'A':
        return 1;
      case 'B':
        return 2;
      case 'C':
        return 3;
      case 'D':
        return 4;
      case 'E':
        return 5;
      case 'F':
        return 6;
      default:
        return 0; // デフォルト値
    }
  }
}
