import 'package:flutter/material.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class NamedScreen extends StatelessWidget {
  const NamedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text('Named Screen'),
      ),
    );
  }
}
