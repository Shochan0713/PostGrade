class Post {
  String id;
  String content;
  String rating;
  DateTime timestamp;
  String userId;

  Post({
    required this.id,
    required this.content,
    required this.rating,
    required this.timestamp,
    required this.userId,
  });

  // JSONからPostオブジェクトを作成するメソッド (Firestoreからのデータ取得時に使用)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      rating: json['rating'],
      timestamp: DateTime.parse(json['timestamp'] as String),
      userId: json['userId'] as String,
    );
  }

  // PostオブジェクトをJSON形式に変換するメソッド (Firestoreにデータ保存時に使用)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'rating': rating,
      'timestamp': timestamp.toIso8601String(),
      'userId': userId,
    };
  }
}
