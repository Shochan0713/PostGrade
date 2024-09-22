import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {'title': '新しいメッセージ', 'content': 'あなたに新しいメッセージがあります。'},
    {'title': 'アップデート完了', 'content': 'アプリが最新バージョンに更新されました。'},
    {'title': 'お知らせ', 'content': '今月のキャンペーンについてのお知らせです。'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   showBackButton: true,
      //   context: context,
      // ),
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
      // bottomNavigationBar: _bottomNavBar,
    );
  }
}
