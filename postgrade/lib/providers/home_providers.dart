import 'package:flutter_riverpod/flutter_riverpod.dart';

final postListProvider = StateProvider<List<String>>((ref) {
  return []; // 初期状態は空のリスト
});
