import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({required this.label, required this.onTab});

  final String label;
  final Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab as void Function()?,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFC5535D),
                Color(0xFFA71F2B),
              ]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(1, 0), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          label,
          style: kLabelButtonStyle,
        ),
      ),
    );
  }
}
