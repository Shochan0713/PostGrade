// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to PostGrade!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/post/1'),
              child: Text('Go to Post Detail'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/settings'),
              child: Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
