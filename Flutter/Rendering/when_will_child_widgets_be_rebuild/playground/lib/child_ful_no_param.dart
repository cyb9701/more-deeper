import 'package:flutter/material.dart';

class ChildFulNoParam extends StatefulWidget {
  const ChildFulNoParam({
    super.key,
  });

  @override
  State<ChildFulNoParam> createState() => _ChildFulNoParamState();
}

class _ChildFulNoParamState extends State<ChildFulNoParam> {
  static const name = 'ful & no param';

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
  void didUpdateWidget(covariant ChildFulNoParam oldWidget) {
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
          const Text(
            name,
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
