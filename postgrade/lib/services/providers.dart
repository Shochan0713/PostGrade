import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgrade/models/post.dart';

// selectedIndexを管理するStateProvider

final selectedIndexProvider = StateProvider<int>((ref) => 0);
final currentIndexProvider = StateProvider<int>((ref) => 0);

final selectedPostProvider = StateProvider<Post?>((ref) => null);
