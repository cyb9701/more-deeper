// 어떠한 provider에도 사용이 가능하다.
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoDisposeModifierProvider = FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(const Duration(seconds: 3));

  return [1, 2, 3, 4, 5];
});
