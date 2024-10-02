import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:postgrade/models/user.dart';
import 'package:postgrade/services/providers.dart';
import 'package:postgrade/styles/custom_app_bar.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';
import 'package:postgrade/views/home_view.dart';
import 'package:postgrade/views/notifications_view.dart';
import 'package:postgrade/views/post.dart';
import 'package:postgrade/views/post_detail_view.dart';
import 'package:postgrade/views/search_view.dart';
import 'package:postgrade/views/user_profile_view.dart';

// ignore: must_be_immutable
class BasePage extends ConsumerWidget {
  BasePage({
    super.key,
  });

  CustomBottomNavBar customBottomNavBar = CustomBottomNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(selectedIndexProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(
        showBackButton: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: customBottomNavBar.getItem(index),
        index: index < 5 ? index : 0,
        onTap: (selectIndex) {
          setCurrentIndex(index: index, ref: ref);
          ref.read(selectedIndexProvider.notifier).state = selectIndex;
        },
        height: customBottomNavBar.height,
        backgroundColor: Colors.white,
        color: customBottomNavBar.color,
        buttonBackgroundColor: customBottomNavBar.buttonBackgroundColor,
        animationDuration: customBottomNavBar.animationDuration,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: getSelectWidget(index: index, ref: ref)),
    );
  }

  Widget getSelectWidget({required int index, required WidgetRef ref}) {
    Widget widget;

    // final firebase.User? user = firebase.FirebaseAuth.instance.currentUser;
    // final String userId = user?.uid ?? '';

    switch (index) {
      case 0:
        widget = const HomePage();
        break;
      case 1:
        widget = const SearchPage();
        break;
      case 2:
        widget = const PostPage();
        break;
      case 3:
        widget = NotificationPage();
        break;
      case 4:
        widget = ProfilePage();
        break;
      case 5:
        final post = ref.watch(selectedPostProvider);
        if (post != null) {
          widget = PostDetailPage(post: post);
        } else {
          widget = const Center(child: Text("ポストが見つかりませんでした。"));
        }
        break;
      default:
        widget = const HomePage();
        break;
    }
    return widget;
  }

  void setCurrentIndex({required int index, required WidgetRef ref}) {
    ref.read(currentIndexProvider.notifier).state = index;
  }
}
