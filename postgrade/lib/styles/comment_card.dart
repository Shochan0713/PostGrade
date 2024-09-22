import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:postgrade/models/comment.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 現在の日付
    final now = DateTime.now();

    // 日付のフォーマットを決定
    String formatDate(DateTime date) {
      final difference = now.difference(date).inDays;

      // 1年以内
      if (difference < 365) {
        return DateFormat('M月d日 EEEE').format(date);
      }
      // 1年以上経過している
      else {
        return DateFormat('yyyy年M月d日 EEEE').format(date);
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.content,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ユーザー: ${comment.userId}',
                  style: const TextStyle(color: Colors.blueGrey),
                ),
                Text(
                  '評価: ${comment.rating}',
                  style: const TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              formatDate(comment.timestamp), // 日本語形式で日付表示
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
