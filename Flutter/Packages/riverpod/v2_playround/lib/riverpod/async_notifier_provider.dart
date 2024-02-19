import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final multipleProvider =
    AsyncNotifierProvider<MultipleAsyncNotifier, List<int>>(MultipleAsyncNotifier.new);

class MultipleAsyncNotifier extends AsyncNotifier<List<int>> {
  @override
  FutureOr<List<int>> build() async {
    return await _get();
  }

  Future<List<int>> _get() async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return [1, 2, 3, 4, 5, 6];
    });
  }
}
