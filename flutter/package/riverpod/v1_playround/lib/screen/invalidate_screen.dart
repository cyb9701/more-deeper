import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/default_layout.dart';
import '../riverpod/state_provider.dart';

class InvalidateScreen extends ConsumerWidget {
  const InvalidateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'Invalidate',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: const Text(
                'up',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).state =
                    ref.read(numberProvider.notifier).state - 1;
              },
              child: const Text(
                'down',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 유효하게 않게 하다.
                // 초기 상태로 되돌아 간다.
                ref.invalidate(numberProvider);
              },
              child: const Text(
                'Invalidate',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
