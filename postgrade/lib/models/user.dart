class User {
  String userId;
  String userName;
  String email;

  User({
    required this.userId,
    required this.userName,
    required this.email,
  });

  // JSONからUserオブジェクトを作成するメソッド (Firestoreからのデータ取得時に使用)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
    );
  }

  // UserオブジェクトをJSON形式に変換するメソッド (Firestoreにデータ保存時に使用)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
    };
  }
}
