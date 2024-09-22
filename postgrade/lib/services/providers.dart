import 'package:flutter_riverpod/flutter_riverpod.dart';

// selectedIndexを管理するStateProvider
final selectedIndexProvider = StateProvider<int>((ref) => 0);
