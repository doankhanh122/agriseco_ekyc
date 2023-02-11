import 'package:agriseco/src/components/page_layout.dart';
import 'package:flutter/material.dart';

import '../../agriseco.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key key, this.nextStep}) : super(key: key);

  final Function nextStep;
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      content: Column(
        children: [
          Text('Third Step From Package!'),
        ],
      ),
    );
  }
}
