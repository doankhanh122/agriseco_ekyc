import 'package:flutter/material.dart';

class DelayWidget extends StatefulWidget {
  const DelayWidget({@required this.delay, @required this.child});
  final Duration delay;
  final Widget child;

  @override
  State<DelayWidget> createState() => _DelayWidgetState();
}

class _DelayWidgetState extends State<DelayWidget> {
  bool _showChild = false;

  @override
  void initState() {
    Future.delayed(widget.delay, () {
      setState(() {
        _showChild = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _showChild ? widget.child : Container();
  }
}
