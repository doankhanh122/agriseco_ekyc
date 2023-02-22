import 'package:flutter/material.dart';

class AgrKeyboardVisibileBuilder extends StatefulWidget {
  AgrKeyboardVisibileBuilder({@required this.builder});
  final Widget Function(BuildContext context, bool isKeyboardVisible) builder;

  @override
  State<AgrKeyboardVisibileBuilder> createState() =>
      _AgrKeyboardVisibileBuilderState();
}

class _AgrKeyboardVisibileBuilderState extends State<AgrKeyboardVisibileBuilder>
    with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInsert = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInsert > 0.0;

    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _isKeyboardVisible);
}
