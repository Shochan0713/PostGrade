import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postgrade/services/providers.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBar({super.key, required this.showBackButton});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: getShowBackButton(showBackButton: showBackButton, ref: ref)
          ? BackButton(
              color: Colors.white,
              onPressed: () {
                // GoRouterを使用して戻る
                if (ref.read(selectedIndexProvider.notifier).state == 0) {
                  print("A");
                  // 最初のページに戻る処理
                  context.go('/'); // 適切なルートに変更
                } else {
                  print("B");
                  ref.read(selectedIndexProvider.notifier).state =
                      ref.watch(currentIndexProvider.notifier).state;
                }
              },
            )
          : null,
      title: const Center(
        child: Text(
          "PostGrade",
          style: TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }

  bool getShowBackButton(
      {required bool showBackButton, required WidgetRef ref}) {
    if (showBackButton) {
      if (ref.read(selectedIndexProvider.notifier).state !=
          ref.watch(currentIndexProvider.notifier).state) {
        return true; // 戻るボタンを表示
      }
    }
    return false; // 戻るボタンを表示しない
  }
}
