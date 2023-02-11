import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  PageLayout({
    @required this.content,
  });

  Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          content,
        ],
      ),
    );
  }
}
