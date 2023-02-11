import 'package:agriseco/src/components/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecondPage extends StatelessWidget {
  final ValueChanged<bool> isDisableBottomBtn;

  const SecondPage({Key key, this.isDisableBottomBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      content: Column(
        children: [
          Text('Second Step From Package!'),
          SvgPicture.asset(
            'assets/images/agr_logo.svg',
            semanticsLabel: 'AGR LOGO',
          ),
        ],
      ),
    );
  }
}
