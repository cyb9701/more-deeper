import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class PathParamScreen extends StatelessWidget {
  const PathParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView(
        children: [
          Text(
            'Path Param : ${GoRouterState.of(context).pathParameters}',
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/path_param/123/code-factory');
            },
            child: const Text(
              'Go Path Param With Name',
            ),
          ),
        ],
      ),
    );
  }
}
