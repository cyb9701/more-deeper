import 'package:flutter/material.dart';
import 'package:playground/child_full_no_param.dart';
import 'package:playground/child_full_with_param.dart';
import 'package:playground/child_less_with_param.dart';

import 'child_less_no_param.dart';

class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('parent --- build');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              value = value + 1;
            });
          },
          child: const Text('setState'),
        ),
        const ChildLessNoParam(),
        ChildLessWithParam(value: value),
        const ChildFullNoParam(),
        ChildFullWithParam(value: value),
      ],
    );
  }
}
