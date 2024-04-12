import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NestedScreen extends StatelessWidget {
  final Widget child;

  const NestedScreen({
    super.key,
    required this.child,
  });

  int getIndex(BuildContext context) {
    return switch (GoRouterState.of(context).uri.toString()) {
      '/nested/a' => 0,
      '/nested/b' => 1,
      _ => 2,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GoRouterState.of(context).uri.toString()),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getIndex(context),
        onTap: (index) {
          String location = switch (index) {
            0 => '/nested/a',
            1 => '/nested/b',
            _ => '/nested/c',
          };
          context.go(location);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_sharp),
            label: 'notification',
          ),
        ],
      ),
    );
  }
}
