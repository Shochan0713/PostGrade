import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Center(
        child: Text(
          "PostGrade",
          style: TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: Colors.grey, // 背景色を設定
      actions: [
        IconButton(
            onPressed: () {
              print('アイコンTap');
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black, // アイコンの色を背景に合わせて変更
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
