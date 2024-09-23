import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrade/models/post.dart';

// Providers
final postTitleProvider = StateProvider<String>((ref) => '');
final postContentProvider = StateProvider<String>((ref) => '');

// Post Screen
class PostPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(postTitleProvider);
    final content = ref.watch(postContentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                ref.read(postTitleProvider.notifier).state = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 4,
              onChanged: (value) {
                ref.read(postContentProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  // Save or submit the post

                  // Implement post submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Post submitted!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Submit Post'),
            ),
          ],
        ),
      ),
    );
  }
}
