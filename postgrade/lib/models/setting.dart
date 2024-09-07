class Setting {
  String theme;
  bool notificationsEnabled;

  Setting({
    required this.theme,
    required this.notificationsEnabled,
  });

  // JSONからSettingオブジェクトを作成するメソッド (Firestoreからのデータ取得時に使用)
  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      theme: json['theme'],
      notificationsEnabled: json['notificationsEnabled'],
    );
  }

  // SettingオブジェクトをJSON形式に変換するメソッド (Firestoreにデータ保存時に使用)
  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
      'notificationsEnabled': notificationsEnabled,
    };
  }
}
