import 'package:flutter/material.dart';
import 'package:playground/child_ful_no_param.dart';
import 'package:playground/child_ful_with_param.dart';
import 'package:playground/child_less_with_param.dart';

import 'child_less_no_param.dart';

class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int value = 0;

  @override
  Widget build(BuildContext context) {
    super.build;
    debugPrint('[build] parent');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ChildLessNoParam(),
          ChildLessWithParam(value: value),
          const ChildFulNoParam(),
          ChildFulWithParam(value: value),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  value = value + 1;
                });
              },
              child: const Text('setState'),
            ),
          ),
        ],
      ),
    );
  }
}
