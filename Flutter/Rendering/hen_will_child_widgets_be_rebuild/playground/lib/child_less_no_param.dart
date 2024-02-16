import 'package:flutter/material.dart';

class ChildLessNoParam extends StatelessWidget {
  const ChildLessNoParam({
    super.key,
  });

  static const name = 'less & no param';

  @override
  Widget build(BuildContext context) {
    debugPrint('[build] $name');
    return Container(
      width: 500,
      height: 100,
      color: Colors.green,
      child: const Center(
        child: Text(
          name,
        ),
      ),
    );
  }
}
