import 'package:flutter/material.dart';

class ChildLessWithParam extends StatelessWidget {
  final int value;

  const ChildLessWithParam({
    super.key,
    required this.value,
  });

  static const name = 'less & param';

  @override
  Widget build(BuildContext context) {
    debugPrint('[build] $name');
    return Container(
      width: 500,
      height: 100,
      color: Colors.green,
      child: Center(
        child: Text(
          '$name\nvalue: $value',
        ),
      ),
    );
  }
}
