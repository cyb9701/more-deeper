import 'package:flutter/material.dart';

class ChildLessWithParam extends StatelessWidget {
  final int value;

  const ChildLessWithParam({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('less & param --- build');
    return Container(
      width: 500,
      height: 100,
      color: Colors.green,
      child: Center(
        child: Text(
          'less & param $value',
        ),
      ),
    );
  }
}
