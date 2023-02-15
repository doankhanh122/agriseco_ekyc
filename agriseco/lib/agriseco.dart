library agriseco;

import 'package:agriseco/src/components/ekyc_stepper.dart';
import 'package:agriseco/src/constants.dart';
import 'package:agriseco/src/pages/page_5.dart';
import 'package:agriseco/src/pages/page_1.dart';
import 'package:agriseco/src/pages/page_4.dart';
import 'package:agriseco/src/pages/page_2.dart';
import 'package:agriseco/src/pages/page_6.dart';
import 'package:agriseco/src/pages/page_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class Agriseco extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CameraApp();
//   }
// }

class Agriseco extends StatefulWidget {
  @override
  State<Agriseco> createState() => _AgrisecoState();
}

class _AgrisecoState extends State<Agriseco> {
  Map<int, bool> isShowBottomButtonStates = {};
  List<EkycStep> steps = [];

  void updateBottomButtonStates({int index, bool newValue}) {
    for (int i = 0; i < isShowBottomButtonStates.length; i++) {
      isShowBottomButtonStates[i] =
          i == index ? newValue : (i == 0 ? true : false);
    }
  }

  @override
  void initState() {
    super.initState();

    // isShowBottomButton = true;
    for (int i = 0; i < 7; i++) {
      isShowBottomButtonStates[i] = i == 0 ? true : false;
    }

    steps = [
      EkycStep(
        content: FirstPage(isShowBottomButtonCallback: (bool value) {
          setState(() {
            updateBottomButtonStates(index: 0, newValue: value);
          });
        }),
        state: EkycStepState.complete,
      ),
      EkycStep(
        content: SecondPage(isShowBottomButtonCallback: (bool value) {
          setState(() {
            updateBottomButtonStates(index: 1, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: ThirdPage(isShowBottomButtonCallback: (bool value) {
          setState(() {
            updateBottomButtonStates(index: 2, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: FourthPage(isShowBottomButtonCallback: (bool value) {
          setState(() {
            updateBottomButtonStates(index: 3, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: FifthPage(isDisableBottomBtn: (bool value) {
          setState(() {
            updateBottomButtonStates(index: 4, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: SixthPage(isDisableBottomBtn: (bool value) {
          setState(() {
            updateBottomButtonStates(index: 5, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: SvgPicture.network(
          'https://agriseco.com.vn/download/ekyc/agr_panel.svg',
          semanticsLabel: 'AGR LOGO',
          height: 50,
        ),
        // title: SvgPicture.asset(
        //   'assets/images/agr_panel.svg',
        //   semanticsLabel: 'AGR LOGO',
        //   height: 50,
        // ),
        elevation: 0,
      ),
      body: EkycStart(
        steps: steps,
        isShowBottomButtonStates: isShowBottomButtonStates,
      ),
    );
  }
}

// List<EkycStep> steps = [
//   EkycStep(
//     content: FirstPage(isDisableBottomBtn: (bool value) {
//       // print(value);
//       // isDisableBottomBtnCallBack(value);
//       widget.isDisableBottomBtnCallBack.call(value);
//     }),
//     state: EkycStepState.complete,
//     bottomButtonState: widget.disableBottomBtn,
//   ),
//   EkycStep(
//     content: SecondPage(isDisableBottomBtn: (bool value) {
//       // print(value);
//       // isDisableBottomBtnCallBack(value);
//       widget.isDisableBottomBtnCallBack.call(value);
//     }),
//     state: EkycStepState.indexed,
//     bottomButtonState: widget.disableBottomBtn,
//   ),
//   EkycStep(
//     content: ThirdPage(isDisableBottomBtn: (bool value) {
//       // print(value);
//       // isDisableBottomBtnCallBack(value);
//       widget.isDisableBottomBtnCallBack.call(value);
//     }),
//     state: EkycStepState.indexed,
//     bottomButtonState: widget.disableBottomBtn,
//   ),
//   EkycStep(
//     content: FourthPage(isDisableBottomBtn: (bool value) {
//       // print(value);
//       // isDisableBottomBtnCallBack(value);
//       widget.isDisableBottomBtnCallBack.call(value);
//     }),
//     state: EkycStepState.indexed,
//     bottomButtonState: widget.disableBottomBtn,
//   ),
//   EkycStep(
//     content: FifthPage(isDisableBottomBtn: (bool value) {
//       // print(value);
//       // isDisableBottomBtnCallBack(value);
//       widget.isDisableBottomBtnCallBack.call(value);
//     }),
//     state: EkycStepState.indexed,
//     bottomButtonState: widget.disableBottomBtn,
//   ),
//   EkycStep(
//     content: SixthPage(isDisableBottomBtn: (bool value) {
//       // print(value);
//       // isDisableBottomBtnCallBack(value);
//       widget.isDisableBottomBtnCallBack.call(value);
//     }),
//     state: EkycStepState.indexed,
//     bottomButtonState: widget.disableBottomBtn,
//   ),
// ];

class EkycStart extends StatefulWidget {
  const EkycStart({this.isShowBottomButtonStates, this.steps});

  final Map<int, bool> isShowBottomButtonStates;
  final List<EkycStep> steps;

  @override
  State<EkycStart> createState() => _EkycStartState();
}

class _EkycStartState extends State<EkycStart> {
  int currentIndex = 0;

  bool isShowBottomButtonAtInitial(int index) {
    if (index != 0) return false;
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EkycStepper(
      isShowBottomButton: widget.isShowBottomButtonStates[currentIndex],
      currentStep: currentIndex,
      ekycSteps: widget.steps,
      onStepContinue: () {
        setState(() {
          currentIndex = currentIndex + 1 >= widget.steps.length
              ? currentIndex
              : currentIndex + 1;
        });
      },
      onStepTapped: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
