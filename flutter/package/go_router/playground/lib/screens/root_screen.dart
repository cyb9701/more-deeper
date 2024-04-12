import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/basic');
            },
            child: const Text(
              'Go Basic',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed('named_screen');
            },
            child: const Text(
              'Go Named',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/push');
            },
            child: const Text(
              'Go Push',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/pop');
            },
            child: const Text(
              'Go Pop',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/path_param/123');
            },
            child: const Text(
              'Go Path Param',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/query_param');
            },
            child: const Text(
              'Go Query Param',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/nested/c');
            },
            child: const Text(
              'Go Nested',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: const Text(
              'Go Login',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/login2');
            },
            child: const Text(
              'Go Login2',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/transition');
            },
            child: const Text(
              'Go Transition',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/error');
            },
            child: const Text(
              'Go Error',
            ),
          ),
        ],
      ),
    );
  }
}
