import 'package:flutter/widgets.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class PrivateScreen extends StatelessWidget {
  const PrivateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text(
          'Private Screen',
        ),
      ),
    );
  }
}
