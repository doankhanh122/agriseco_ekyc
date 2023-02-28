import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({@required this.label, @required this.onTab});

  final String label;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
            color: kGreenColor,
            border: Border.all(
              color: kBackgroundColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 8,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: kYellowColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
