import 'package:flutter/material.dart';
import 'package:riverpod_playround/layout/default_layout.dart';
import 'package:riverpod_playround/screen/async_notifier_provider_screen.dart';
import 'package:riverpod_playround/screen/notifier_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Home Screen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotifierProviderScreen(),
                ),
              );
            },
            child: const Text(
              'Notifier Provider',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AsyncNotifierProviderScreen(),
                ),
              );
            },
            child: const Text(
              'Async Notifier Provider',
            ),
          ),
        ],
      ),
    );
  }
}
