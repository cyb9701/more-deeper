import 'package:flutter/material.dart';

class ChildFulWithParam extends StatefulWidget {
  final int value;

  const ChildFulWithParam({
    super.key,
    required this.value,
  });

  @override
  State<ChildFulWithParam> createState() => _ChildFulWithParamState();
}

class _ChildFulWithParamState extends State<ChildFulWithParam> {
  static const name = 'ful & param';

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
  void didUpdateWidget(covariant ChildFulWithParam oldWidget) {
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
