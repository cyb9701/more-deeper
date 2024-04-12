import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<int>> state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'Future Provider',
      body: Center(
        child: switch (state) {
          AsyncData(:final value) => Text(
              value.toString(),
              textAlign: TextAlign.center,
            ),
          AsyncError(:final error, :final stackTrace) => Text(error.toString()),
          _ => const CircularProgressIndicator(),
        },
      ),
    );
  }
}
