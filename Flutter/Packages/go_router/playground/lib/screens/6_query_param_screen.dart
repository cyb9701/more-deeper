import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class QueryParamScreen extends StatelessWidget {
  const QueryParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView(
        children: [
          Text(
            'Path Param : ${GoRouterState.of(context).uri.queryParameters}',
          ),
          ElevatedButton(
            onPressed: () {
              context.push(
                Uri(
                  path: '/query_param',
                  queryParameters: {
                    'name': 'codefactory',
                    'age': '123',
                  },
                ).toString(),
              );
            },
            child: const Text(
              'Push Query Param',
            ),
          ),
        ],
      ),
    );
  }
}
