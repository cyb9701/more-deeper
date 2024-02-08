import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class PopBaseScreen extends StatelessWidget {
  const PopBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: ListView(
      children: [
        ElevatedButton(
          onPressed: () async {
            final result = await context.push('/pop/return');

            debugPrint(result?.toString());
          },
          child: const Text(
            'Push Pop Return Screen',
          ),
        ),
      ],
    ));
  }
}
