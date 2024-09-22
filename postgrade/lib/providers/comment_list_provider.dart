import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrade/models/comment.dart';

final commentListProvider = FutureProvider<List<Comment>>((ref) async {
  // サンプルコメントのリストを作成
  List<Comment> sampleComments = [
    Comment(
      commentId: '1',
      postId: '1',
      userId: 'user1',
      content: 'サンプルコメント 1',
      timestamp: DateTime.now().subtract(Duration(minutes: 10)),
      rating: 'A',
    ),
    Comment(
      commentId: '2',
      postId: '1',
      userId: 'user2',
      content: 'サンプルコメント 2',
      timestamp: DateTime.now().subtract(Duration(minutes: 20)),
      rating: 'B',
    ),
    Comment(
      commentId: '3',
      postId: '1',
      userId: 'user3',
      content: 'サンプルコメント 3',
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      rating: 'C',
    ),
    Comment(
      commentId: '4',
      postId: '1',
      userId: 'user4',
      content: 'サンプルコメント 4',
      timestamp: DateTime.now().subtract(Duration(minutes: 40)),
      rating: 'D',
    ),
    // 他のサンプルコメントを追加
  ];

  return sampleComments;
});
