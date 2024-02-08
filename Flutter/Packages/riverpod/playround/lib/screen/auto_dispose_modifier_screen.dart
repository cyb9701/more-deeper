import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';

import '../riverpod/auto_dispose_modifier_provider.dart';

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);

    return DefaultLayout(
      title: 'Auto Dispose Modifier',
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
