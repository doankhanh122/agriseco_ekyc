import 'package:agriseco/src/components/page_layout.dart';
import 'package:flutter/material.dart';

import '../../agriseco.dart';

class SixthPage extends StatelessWidget {
  final ValueChanged<bool> isDisableBottomBtn;

  const SixthPage({Key key, this.isDisableBottomBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      content: Column(
        children: [
          Text('Sixth Step From Package!'),
        ],
      ),
    );
  }
}
