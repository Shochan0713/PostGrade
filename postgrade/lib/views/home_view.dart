// lib/pages/home_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/styles/custom_app_bar.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';

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
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
    Post(id: '3', content: 'サンプル投稿 3', rating: 'C'),
  ];
  print('サンプルデータ: $samplePosts'); // コンソールにサンプルデータを出力
  return Future.delayed(
      const Duration(seconds: 1), () => samplePosts); // データ取得の遅延を模倣
});

class HomePage extends ConsumerWidget {
  CustomAppBar _customAppBar = const CustomAppBar(
    title: 'Home',
  );
  CustomBottomNavBar _bottomNavBar = const CustomBottomNavBar();

  HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postListProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _customAppBar,
      body: postList.when(
        data: (samplePosts) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = samplePosts[index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
                      elevation: 4.0,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          post.content,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          'AI評価: ${post.rating}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          print("テキストクリック");
                          // 投稿詳細ページに遷移する
                          context.go('/post/${post.id}');
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
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
