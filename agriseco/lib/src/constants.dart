import 'package:flutter/material.dart';

const kYellowColor = Color(0xFFfdba1a);
const kBackgroundColor = Color(0xFFa51d2a);
const kSecondaryTextColor = Color(0xFFcb5427);
const kPrimaryTextColor = Colors.black38;
const kTitleTextColor = Colors.white;

const TextStyle kLabelButtonStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
);

const TextStyle kTileStyle = TextStyle(
    color: Color(0xFFa51d2a), fontSize: 15, fontWeight: FontWeight.bold);

const TextStyle kBodyStyle = TextStyle(
  color: Colors.black38,
  fontSize: 10,
);

final Widget a = Stepper(
  steps: [],
);

final Widget b = ChoiceChip(label: Text('A'), selected: true);

const TextStyle kIncompleteStepCircleTextStyle = TextStyle(color: Colors.white);
const TextStyle kCompleteStepCircleTextStyle = TextStyle(color: Colors.black38);
