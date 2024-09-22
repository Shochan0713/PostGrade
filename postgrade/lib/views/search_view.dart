import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // パディングを追加
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (query) => _search(query),
              ),
              const SizedBox(height: 16), // 検索ボックスとリストの間にスペース
              _searchResults.isEmpty
                  ? const Text('結果がありません')
                  : ListView.builder(
                      shrinkWrap: true, // 親のサイズに合わせる
                      physics:
                          const NeverScrollableScrollPhysics(), // スクロールを無効化
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchResults[index]),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
