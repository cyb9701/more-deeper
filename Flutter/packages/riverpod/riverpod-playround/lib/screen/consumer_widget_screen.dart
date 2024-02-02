import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/code_generation_provider.dart';

class ConsumerWidgetScreen extends ConsumerWidget {
  const ConsumerWidgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('---BUILD---');

    final state1 = ref.watch(goStateProvider);

    return DefaultLayout(
      title: 'Consumer Widget',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('state1: $state1'),

            // consumer widget.
            Consumer(
              builder: (context, ref, child) {
                final state3 = ref.watch(goKeepAliveStateFutureProvider);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state3.when(
                      data: (data) => Text('state3: $data'),
                      error: (e, s) => Text(e.toString()),
                      loading: () => const Text('state3: Loading'),
                    ),
                    if (child != null) child
                  ],
                );
              },

              // child로 지정한 위젯은.
              // 위에서 상태변경으로 build가 재실행될 때에도 재실행되지 않는다.
              // 해당 위젯은 한번만 빌드된다.
              child: const Text(' // Hello'),
            ),

            // other widget.
            const _StateFiveWidget(),
          ],
        ),
      ),
    );
  }
}

class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(goStateNotifierProvider);

    return Row(
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
    );
  }
}
