import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;

  const DefaultLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          GoRouterState.of(context).uri.toString(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
