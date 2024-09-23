// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/services/providers.dart';

// final postListProvider = FutureProvider<List<Post>>((ref) async {
//   QuerySnapshot querySnapshot =
//       await FirebaseFirestore.instance.collection('posts').get();
//   return querySnapshot.docs.map((doc) {
//     return Post.fromJson(doc.data() as Map<String, dynamic>);
//   }).toList();
// });

final postListProvider = FutureProvider<List<Post>>((ref) async {
  // サンプルデータのリストを作成
  List<Post> samplePosts = [
    Post(id: '1', content: 'サンプル投稿 1', rating: 'A'),
    Post(id: '2', content: 'サンプル投稿 2', rating: 'B'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'D'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'E'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'F'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
  ];
  // ignore: avoid_print
  print('サンプルデータ: $samplePosts'); // コンソールにサンプルデータを出力
  return Future.delayed(
      const Duration(seconds: 1), () => samplePosts); // データ取得の遅延を模倣
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: CustomAppBar(
      //   showBackButton: false,
      //   context: context,
      // ),
      body: postList.when(
        data: (samplePosts) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = samplePosts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 12.0),
                      elevation: 4.0,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Row(
                          children: [
                            Text(
                              post.content,
                              style: const TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(), // 左右にスペースを挿入してAI評価を右端に固定
                            Column(children: [
                              const Text(
                                'AI評価',
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                '${post.rating}',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: _getRatingColor('${post.rating}'),
                                ),
                              ),
                            ]), // 左右の要素間のスペース
                          ],
                        ),
                        onTap: () {
                          print('ボタンがタップされました。');
                          ref.read(selectedPostProvider.notifier).state =
                              post; // 選択されたポストを保存
                          ref.read(selectedIndexProvider.notifier).state =
                              5; // PostDetailPage を表示
                        },
                      ),
                    );
                  },
                  childCount: samplePosts.length,
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('エラーが発生しました'),
              const SizedBox(height: 8),
              Text(error.toString()),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _bottomNavBar,
    );
  }

  Color _getRatingColor(String rating) {
    switch (rating) {
      case 'A':
        return Colors.amber;
      case 'B':
        return Colors.red;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.green;
      case 'E':
        return Colors.blue;
      case 'F':
        return Colors.indigo;
      default:
        return Colors.black;
    }
  }
}
