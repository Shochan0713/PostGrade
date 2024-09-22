import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final CustomBottomNavBar _bottomNavBar = const CustomBottomNavBar();
  List<String> _searchResults = [];
  List<String> _data = ['りんご', 'バナナ', 'さくらんぼ', 'デーツ']; // サンプルデータ

  void _search(String query) {
    setState(() {
      _searchResults = _data.where((item) => item.contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Navigatorで戻る
            } else {
              print("スタックに戻るページがありません");
            }
          },
        ),
        title: TextField(
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
              borderSide:
                  BorderSide(color: Colors.black, width: 2.0), // フォーカス時の黒い下線
            ),
          ),
          style: const TextStyle(color: Colors.black), // テキストの色を黒に
          onChanged: (query) => _search(query), // 入力が変わるたびに検索
        ),
        backgroundColor: Colors.grey,
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_searchResults[index]),
          );
        },
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
