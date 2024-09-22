import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/providers/comment_list_provider.dart';
import 'package:postgrade/styles/comment_card.dart';
import 'package:postgrade/styles/custom_app_bar.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ソート順を管理するプロバイダー
final sortOrderProvider =
    StateProvider<SortOrder>((ref) => SortOrder.highToLow);

// ソート順を定義する列挙型
enum SortOrder { highToLow, lowToHigh }

class PostDetailPage extends ConsumerWidget {
  final Post post;

  final CustomBottomNavBar _bottomNavBar = const CustomBottomNavBar();

  const PostDetailPage({super.key, required this.post});

  // // Firestoreからコメントを取得するメソッド
  // Stream<List<Comment>> getComments() {
  //   return FirebaseFirestore.instance
  //       .collection('comments') // Firestoreのコメントコレクション
  //       .where('postId', isEqualTo: post.id) // 現在の投稿に紐づくコメントを取得
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList());
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentAsyncValue = ref.watch(commentListProvider);
    final sortOrder = ref.watch(sortOrderProvider);
    print('投稿詳細画面表示');
    return Scaffold(
      appBar: CustomAppBar(showBackButton: true, context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.content,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'AI評価: ${post.rating}',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              '投稿者: ユーザー名', // 投稿者の情報をここに表示
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '投稿日時: 2024年9月1日', // 投稿の日時
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'コメントセクション',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  // ソートボタン
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref.read(sortOrderProvider.notifier).state =
                              SortOrder.highToLow;
                        },
                        child: Text('評価が高い順'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(sortOrderProvider.notifier).state =
                              SortOrder.lowToHigh;
                        },
                        child: Text('評価が低い順'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: commentAsyncValue.when(
                      data: (comments) {
                        print('コメントデータ: $comments'); // デバッグ用
                        if (comments.isEmpty) {
                          return const Center(child: Text('コメントがまだありません'));
                        }

                        // ソート順に基づいてソートする
                        comments.sort((a, b) {
                          if (sortOrder == SortOrder.highToLow) {
                            return a
                                .getRatingValue()
                                .compareTo(b.getRatingValue());
                          } else {
                            return b
                                .getRatingValue()
                                .compareTo(a.getRatingValue());
                          }
                        });
                        return ListView(
                          children: comments.map((comment) {
                            return CommentCard(comment: comment);
                          }).toList(),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, _) =>
                          Center(child: Text('コメントの読み込みに失敗しました: $e')),
                    ),
                  ),

                  // Expanded(
                  //   child: StreamBuilder<List<Comment>>(
                  //     stream: getComments(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return const Center(
                  //             child: CircularProgressIndicator());
                  //       }
                  //       if (snapshot.hasError) {
                  //         return const Center(child: Text('コメントの読み込みに失敗しました。'));
                  //       }
                  //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //         return const Center(child: Text('コメントがまだありません'));
                  //       }

                  //       return ListView(
                  //         children: snapshot.data!.map((comment) {
                  //           return ListTile(
                  //               title: Text(comment.content),
                  //               subtitle: Text(
                  //                   '評価: ${comment.rating}, ユーザー: ${comment.userId}'),
                  //               trailing: Text(
                  //                 comment.timestamp.toString(),
                  //                 style: TextStyle(color: Colors.grey),
                  //               ));
                  //         }).toList(),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
