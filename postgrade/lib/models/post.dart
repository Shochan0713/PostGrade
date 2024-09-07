class Post {
  String id;
  String content;
  String rating;

  Post({
    required this.id,
    required this.content,
    required this.rating,
  });

  // JSONからPostオブジェクトを作成するメソッド (Firestoreからのデータ取得時に使用)
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      rating: json['rating'],
    );
  }

  // PostオブジェクトをJSON形式に変換するメソッド (Firestoreにデータ保存時に使用)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'rating': rating,
    };
  }
}
