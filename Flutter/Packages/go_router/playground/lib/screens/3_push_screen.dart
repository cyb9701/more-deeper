import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_playground/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              /**
               * 선언 그대로 우리가 라우트를 새로 생성한다.
               * 
               * Ex.
               * 현재 페이지: / -> /push
               * /basic으로 go: / -> /basic
               * 
               * go 함수는 router에서 불러온 route 이외에
               * 최상단 route인 '/' 부터 전부 불러온다.
               */
              context.go('/basic');
            },
            child: const Text(
              'Go Basic Screen',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              /**
               * 현재 라우트가 형성이 되어 있는 상태에서
               * 그대로 새로운 라우트를 그 위에 올린다.
               */
              context.push('/basic');
            },
            child: const Text(
              'Push Basic Screen',
            ),
          ),
        ],
      ),
    );
  }
}
