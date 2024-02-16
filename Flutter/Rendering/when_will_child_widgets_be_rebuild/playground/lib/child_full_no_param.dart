import 'package:flutter/material.dart';

class ChildFullNoParam extends StatefulWidget {
  const ChildFullNoParam({
    super.key,
  });

  @override
  State<ChildFullNoParam> createState() => _ChildFullNoParamState();
}

class _ChildFullNoParamState extends State<ChildFullNoParam> {
  static const name = 'full & no param';

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
  void didUpdateWidget(covariant ChildFullNoParam oldWidget) {
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
