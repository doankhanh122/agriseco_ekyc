import 'package:flutter/material.dart';

class AutoHideWidget extends StatefulWidget {
  const AutoHideWidget(
      {@required this.delay, @required this.child, this.restartWidget});
  final Duration delay;
  final Widget child;
  final Function restartWidget;

  @override
  State<AutoHideWidget> createState() => _AutoHideWidgetState();
}

class _AutoHideWidgetState extends State<AutoHideWidget> {
  bool _showChild = true;

  @override
  void initState() {
    Future.delayed(widget.delay, () {
      setState(() {
        _showChild = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _showChild ? widget.child : Container();
  }
}
