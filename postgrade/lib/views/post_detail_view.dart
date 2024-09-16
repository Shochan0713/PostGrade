import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:postgrade/models/post.dart';
import 'package:postgrade/styles/custom_app_bar.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  final CustomBottomNavBar _bottomNavBar = const CustomBottomNavBar();

  PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        const ListTile(
                          title: Text('コメント1'),
                          subtitle: Text('ユーザーAが投稿したコメント'),
                        ),
                        const ListTile(
                          title: Text('コメント2'),
                          subtitle: Text('ユーザーBが投稿したコメント'),
                        ),
                        // 他のコメントをリストで表示
                      ],
                    ),
                  ),
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
