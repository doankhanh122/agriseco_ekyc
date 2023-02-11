library agriseco;

import 'package:agriseco/src/components/ekyc_stepper.dart';
import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/constants.dart';
import 'package:agriseco/src/pages/page_5.dart';
import 'package:agriseco/src/pages/page_1.dart';
import 'package:agriseco/src/pages/page_4.dart';
import 'package:agriseco/src/pages/page_2.dart';
import 'package:agriseco/src/pages/page_6.dart';
import 'package:agriseco/src/pages/page_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EkycFirstPage extends StatefulWidget {
  @override
  State<EkycFirstPage> createState() => _EkycFirstPageState();
}

class _EkycFirstPageState extends State<EkycFirstPage> {
  final totalIndex = 6;
  int currentIndex = 0;
  void nextPage() {}

  List<EkycStep> steps = [
    EkycStep(content: FirstPage(), state: EkycStepState.complete),
    EkycStep(content: SecondPage(), state: EkycStepState.indexed),
    EkycStep(content: ThirdPage(), state: EkycStepState.indexed),
    EkycStep(content: FourthPage(), state: EkycStepState.indexed),
    EkycStep(content: FifthPage(), state: EkycStepState.indexed),
    EkycStep(content: SixthPage(), state: EkycStepState.indexed),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        backgroundColor: kBackgroundColor,
        title: SvgPicture.asset(
          'assets/images/agr_panel.svg',
          semanticsLabel: 'AGR LOGO',
          height: 50,
        ),
        elevation: 0,
      ),
      body: EkycStepper(
        currentStep: currentIndex,
        ekycSteps: steps,
        onStepContinue: () {
          setState(() {
            currentIndex = currentIndex + 1 >= steps.length
                ? currentIndex
                : currentIndex + 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
