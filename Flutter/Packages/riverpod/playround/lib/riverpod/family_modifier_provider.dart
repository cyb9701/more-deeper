import 'package:flutter_riverpod/flutter_riverpod.dart';

// 어떠한 provider에도 사용이 가능하다.
final familyModifierProvider = FutureProvider.family<List<int>, int>((ref, data) async {
  await Future.delayed(const Duration(seconds: 3));

  return List.generate(5, (index) => index * data);
});
