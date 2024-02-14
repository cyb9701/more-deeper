import 'package:flutter/material.dart';

class ChildFullNoParam extends StatefulWidget {
  const ChildFullNoParam({
    super.key,
  });

  @override
  State<ChildFullNoParam> createState() => _ChildFullNoParamState();
}

class _ChildFullNoParamState extends State<ChildFullNoParam> {
  @override
  void initState() {
    debugPrint('full & x --- initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint('full & x --- didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ChildFullNoParam oldWidget) {
    debugPrint('full & x --- didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('full & x --- build');
    return Container(
      width: 500,
      height: 100,
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'full & x',
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
