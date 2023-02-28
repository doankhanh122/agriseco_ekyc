import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

const kYellowColor = Color(0xFFfdba1a);
const kBackgroundColor = Color(0xFFa51d2a);
const kSecondaryTextColor = Color(0xFFcb5427);
const kGreenColor = Color(0xFFE6F0E0);
const kPrimaryTextColor = Colors.black38;
const kTitleTextColor = Colors.white;

const TextStyle kLabelButtonStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
);

const TextStyle kLabelBottomButtonStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
);

const TextStyle kTileStyle = TextStyle(
    color: Color(0xFFa51d2a), fontSize: 20, fontWeight: FontWeight.bold);

const TextStyle kBodyTextStyle = TextStyle(
  color: Colors.black38,
);
const TextStyle kBodyItalicTextStyle = TextStyle(
  color: Colors.black38,
  fontStyle: FontStyle.italic,
);

const TextStyle kBodyBoldTextStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.bold,
);

final Widget a = Stepper(
  steps: [],
);

final Widget b = DropDownTextField(dropDownList: []);

final Widget c = ChoiceChip(label: Text('A'), selected: true);

const TextStyle kIncompleteStepCircleTextStyle = TextStyle(color: Colors.white);
const TextStyle kCompleteStepCircleTextStyle = TextStyle(color: Colors.black38);
