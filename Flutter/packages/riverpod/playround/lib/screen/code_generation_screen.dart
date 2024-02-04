import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(goStateProvider);
    final state2 = ref.watch(goStateFutureProvider);
    final state3 = ref.watch(goKeepAliveStateFutureProvider);
    final state4 = ref.watch(goStateMultiplyProvider(number1: 10, number2: 20));
    final state5 = ref.watch(goStateNotifierProvider);

    return DefaultLayout(
      title: 'Code Generation',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('state1: $state1'),
            state2.when(
              data: (data) => Text('state2: $data'),
              error: (e, s) => Text(e.toString()),
              loading: () => const Text('state2: Loading'),
            ),
            state3.when(
              data: (data) => Text('state3: $data'),
              error: (e, s) => Text(e.toString()),
              loading: () => const Text('state3: Loading'),
            ),
            Text('state4: $state4'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('state5: $state5'),
                ElevatedButton(
                  onPressed: () => ref.read(goStateNotifierProvider.notifier).decrease(),
                  child: const Text('decrease'),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(goStateNotifierProvider.notifier).increase(),
                  child: const Text('increase'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
