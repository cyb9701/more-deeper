import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/select_provider.dart';

class SelectScreen extends ConsumerWidget {
  const SelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('---BUILD---');
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));

    ref.listen(selectProvider, (previous, next) {
      debugPrint('next: $next');
    });

    return DefaultLayout(
      title: 'Select',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   state.name.toString(),
            // ),
            // Text(
            //   state.quantity.toString(),
            // ),
            // Text(
            //   state.hasBought.toString(),
            // ),
            // Text(
            //   state.isSpicy.toString(),
            // ),
            Text(
              state.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleBougth();
              },
              child: const Text(
                'toggleBougth',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: const Text(
                'toggleIsSpicy',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
