import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/riverpod/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multipleStreamProvider);

    return DefaultLayout(
        title: 'Stream Provider',
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
        ));
  }
}
