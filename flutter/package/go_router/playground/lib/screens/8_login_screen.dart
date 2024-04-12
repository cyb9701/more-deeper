import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

import '../route/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            if (GoRouterState.of(context).uri.toString() == '/login') {
              context.go('/login/private');
            } else {
              context.go('/login2/private');
            }
          },
          child: const Text(
            'Go To Private Sceen',
          ),
        ),
        Text(
          'Login State: $authState',
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              authState = !authState;
            });
          },
          child: Text(
            authState ? 'Logout' : 'Login',
          ),
        ),
      ],
    ));
  }
}
