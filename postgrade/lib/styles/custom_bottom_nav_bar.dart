import 'package:flutter/material.dart';

class CustomBottomNavBar {
  final items = const [
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.search,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.add,
      size: 30,
      color: Colors.white,
    ), // 追加ボタン
    Icon(
      Icons.notifications,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.account_circle,
      size: 30,
      color: Colors.white,
    ),
  ];

  Color color = Colors.grey;
  Color backgroundColor = Colors.white;
  Color? buttonBackgroundColor = Colors.grey[400];
  double height = 60;
  Duration animationDuration = const Duration(milliseconds: 300);

  List<Icon> getItem(int index) {
    print("選択中のインデックス: $index");
    Color itemsColorWhite = Colors.white;
    Color itemsGrey = Colors.black;

    final items = [
      Icon(
        Icons.home,
        size: 30,
        color: index == 0 ? itemsColorWhite : itemsGrey,
      ),
      Icon(
        Icons.search,
        size: 30,
        color: index == 1 ? itemsColorWhite : itemsGrey,
      ),
      Icon(
        Icons.add,
        size: 30,
        color: index == 2 ? itemsColorWhite : itemsGrey,
      ), // 追加ボタン
      Icon(
        Icons.notifications,
        size: 30,
        color: index == 3 ? itemsColorWhite : itemsGrey,
      ),
      Icon(
        Icons.account_circle,
        size: 30,
        color: index == 4 ? itemsColorWhite : itemsGrey,
      ),
    ];

    return items;
  }
}
