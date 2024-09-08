import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false; // 検索状態を管理するフラグ
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
              controller: _searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey), // ヒントテキストの色
                filled: true, // 背景を塗りつぶす
                fillColor: Colors.white, // 背景色を白に設定
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // 黒い下線
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black, width: 2.0), // フォーカス時の黒い下線
                ),
              ),
              style: const TextStyle(color: Colors.black), // テキストの色を黒に
            )
          : const Center(
              child: Text(
                "PostGrade",
                style: TextStyle(fontSize: 30),
              ),
            ),
      backgroundColor: Colors.grey,
      leading: isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                setState(() {
                  isSearching = false;
                  _searchController.clear(); // 検索バーを閉じた時にテキストをクリア
                });
              },
            )
          : null,
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
