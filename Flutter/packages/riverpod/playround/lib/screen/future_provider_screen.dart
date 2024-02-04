import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
      title: 'Future Provider',
      body: Center(
        child: state.when(
          data: (data) {
            return Text(
              data.toString(),
              textAlign: TextAlign.center,
            );
          },
          error: (e, s) {
            return Text(e.toString());
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
