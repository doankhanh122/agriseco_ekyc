import 'package:agriseco/src/components/page_layout.dart';
import 'package:flutter/material.dart';

import '../../agriseco.dart';

class FifthPage extends StatelessWidget {
  const FifthPage({Key key, this.isDisableBottomBtn});
  final ValueChanged<bool> isDisableBottomBtn;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      content: Column(
        children: [
          Text('Fifth Step From Package!'),
        ],
      ),
    );
  }
}
