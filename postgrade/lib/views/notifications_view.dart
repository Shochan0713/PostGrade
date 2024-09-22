import 'package:flutter/material.dart';
import 'package:postgrade/styles/custom_app_bar.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {'title': '新しいメッセージ', 'content': 'あなたに新しいメッセージがあります。'},
    {'title': 'アップデート完了', 'content': 'アプリが最新バージョンに更新されました。'},
    {'title': 'お知らせ', 'content': '今月のキャンペーンについてのお知らせです。'},
  ];
  final CustomBottomNavBar _bottomNavBar = const CustomBottomNavBar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: true,
        context: context,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            child: ListTile(
              title: Text(notification['title'] ?? ''),
              subtitle: Text(notification['content'] ?? ''),
              onTap: () {
                // 通知をタップしたときのアクションを追加
                print('${notification['title']}がタップされました');
              },
            ),
          );
        },
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
