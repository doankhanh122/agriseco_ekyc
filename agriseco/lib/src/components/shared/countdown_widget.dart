import 'dart:async';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({required this.seconds, required this.whenDone});

  final int seconds;
  final VoidCallback whenDone;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  int _countdown = 0;

  @override
  void initState() {
    _countdown = widget.seconds;
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel();
          widget.whenDone.call();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_countdown',
      style: TextStyle(fontSize: 48),
    );
  }
}
