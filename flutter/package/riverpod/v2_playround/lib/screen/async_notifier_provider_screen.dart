import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/async_notifier_provider.dart';

class AsyncNotifierProviderScreen extends ConsumerWidget {
  const AsyncNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<int>> state = ref.watch(multipleProvider);

    return DefaultLayout(
      title: 'Async Notifier Provider',
      body: Center(
        child: switch (state) {
          AsyncData(:final value) => Text(
              value.toString(),
              textAlign: TextAlign.center,
            ),
          AsyncError(:final error, :final stackTrace) => Text(
              '${error.toString()} / ${stackTrace.toString()}',
            ),
          _ => const CircularProgressIndicator(),
        },
      ),
    );
  }
}
