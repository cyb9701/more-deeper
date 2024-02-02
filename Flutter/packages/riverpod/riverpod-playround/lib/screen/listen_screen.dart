import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_playround/riverpod/listen_provider.dart';

import '../layout/default_layout.dart';

class ListenScreen extends ConsumerStatefulWidget {
  const ListenScreen({super.key});

  @override
  ConsumerState<ListenScreen> createState() => _ListenScreenState();
}

class _ListenScreenState extends ConsumerState<ListenScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 10,
      vsync: this,
      initialIndex: ref.read(listenProvider),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(listenProvider, (previous, next) {
      debugPrint(previous.toString());
      debugPrint(next.toString());

      if (previous != next) {
        _tabController.animateTo(next);
      }
    });

    return DefaultLayout(
      title: 'Listen',
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          10,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                index.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(listenProvider.notifier).update((state) => state == 9 ? 9 : state + 1);
                },
                child: const Text(
                  'next',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(listenProvider.notifier).update((state) => state == 0 ? 0 : state - 1);
                },
                child: const Text(
                  'previous',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
