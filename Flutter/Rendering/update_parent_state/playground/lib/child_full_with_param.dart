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
  @override
  void initState() {
    debugPrint('full & param --- initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('full & param --- didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ChildFullWithParam oldWidget) {
    debugPrint('full & param --- didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('full & param --- build');
    return Container(
      width: 500,
      height: 100,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'full & param ${widget.value}',
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
