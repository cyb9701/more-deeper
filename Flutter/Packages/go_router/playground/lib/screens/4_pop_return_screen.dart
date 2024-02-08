import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class PopReturnScreen extends StatelessWidget {
  const PopReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            context.pop('code factory');
          },
          child: const Text(
            'Pop',
          ),
        ),
      ],
    ));
  }
}
