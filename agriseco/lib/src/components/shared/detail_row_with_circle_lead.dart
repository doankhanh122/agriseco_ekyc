import 'package:flutter/material.dart';

import '../../constants.dart';

class DetailRowWithCircleLead extends StatelessWidget {
  const DetailRowWithCircleLead({@required this.child, this.isLead = true});

  final Widget child;
  final bool isLead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLead ? _CircleLead() : Container(),
          child,
        ],
      ),
    );
  }
}

class _CircleLead extends StatelessWidget {
  const _CircleLead({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
          color: kYellowColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: kBackgroundColor,
            style: BorderStyle.solid,
          )),
    );
  }
}
