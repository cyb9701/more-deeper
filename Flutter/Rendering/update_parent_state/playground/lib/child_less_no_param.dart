import 'package:flutter/material.dart';

class ChildLessNoParam extends StatelessWidget {
  const ChildLessNoParam({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('less & x --- build');
    return Container(
      width: 500,
      height: 100,
      color: Colors.green,
      child: const Center(
        child: Text(
          'less & x',
        ),
      ),
    );
  }
}
