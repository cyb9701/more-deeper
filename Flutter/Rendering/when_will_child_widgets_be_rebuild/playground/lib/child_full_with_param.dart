import 'package:flutter/material.dart';

class ChildFullWithParam extends StatefulWidget {
  final int value;

  const ChildFullWithParam({
    super.key,
    required this.value,
  });

  @override
  State<ChildFullWithParam> createState() => _ChildFullWithParamState();
}

class _ChildFullWithParamState extends State<ChildFullWithParam> {
  static const name = 'full & param';

  @override
  void initState() {
    debugPrint('[initState] $name');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('[didChangeDependencies] $name');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ChildFullWithParam oldWidget) {
    debugPrint('[didUpdateWidget] $name');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('[build] $name');
    return Container(
      width: 500,
      height: 100,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '$name\nvalue: ${widget.value}',
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            child: const Text(
              'setState',
            ),
          ),
        ],
      ),
    );
  }
}
