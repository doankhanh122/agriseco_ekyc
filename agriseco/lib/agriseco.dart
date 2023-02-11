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

class Agriseco extends StatefulWidget {
  @override
  State<Agriseco> createState() => _AgrisecoState();
}

class _AgrisecoState extends State<Agriseco> {
  bool disableBottomBtn = false;
  void callBack(bool value) {
    setState(() {
      disableBottomBtn = value;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   disableBottomBtn = false;
  // }

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
      body: EkycFirstPage(
        disableBottomBtn: disableBottomBtn,
        isDisableBottomBtnCallBack: (bool value) {
          callBack(value);
        },
      ),
    );
  }
}

class EkycFirstPage extends StatefulWidget {
  const EkycFirstPage(
      {Key key, this.disableBottomBtn, this.isDisableBottomBtnCallBack})
      : super(key: key);

  final bool disableBottomBtn;
  final ValueChanged<bool> isDisableBottomBtnCallBack;

  @override
  State<EkycFirstPage> createState() => _EkycFirstPageState();
}

class _EkycFirstPageState extends State<EkycFirstPage> {
  final totalIndex = 6;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<EkycStep> steps = [
      EkycStep(
        content: FirstPage(isDisableBottomBtn: (bool value) {
          // print(value);
          // isDisableBottomBtnCallBack(value);
          widget.isDisableBottomBtnCallBack.call(value);
        }),
        state: EkycStepState.complete,
        isDisableBottomBtn: widget.disableBottomBtn,
      ),
      EkycStep(
        content: SecondPage(isDisableBottomBtn: (bool value) {
          // print(value);
          // isDisableBottomBtnCallBack(value);
          widget.isDisableBottomBtnCallBack.call(value);
        }),
        state: EkycStepState.indexed,
        isDisableBottomBtn: widget.disableBottomBtn,
      ),
      EkycStep(
        content: ThirdPage(isDisableBottomBtn: (bool value) {
          // print(value);
          // isDisableBottomBtnCallBack(value);
          widget.isDisableBottomBtnCallBack.call(value);
        }),
        state: EkycStepState.indexed,
        isDisableBottomBtn: widget.disableBottomBtn,
      ),
      EkycStep(
        content: FourthPage(isDisableBottomBtn: (bool value) {
          // print(value);
          // isDisableBottomBtnCallBack(value);
          widget.isDisableBottomBtnCallBack.call(value);
        }),
        state: EkycStepState.indexed,
        isDisableBottomBtn: widget.disableBottomBtn,
      ),
      EkycStep(
        content: FifthPage(isDisableBottomBtn: (bool value) {
          // print(value);
          // isDisableBottomBtnCallBack(value);
          widget.isDisableBottomBtnCallBack.call(value);
        }),
        state: EkycStepState.indexed,
        isDisableBottomBtn: widget.disableBottomBtn,
      ),
      EkycStep(
        content: SixthPage(isDisableBottomBtn: (bool value) {
          // print(value);
          // isDisableBottomBtnCallBack(value);
          widget.isDisableBottomBtnCallBack.call(value);
        }),
        state: EkycStepState.indexed,
        isDisableBottomBtn: widget.disableBottomBtn,
      ),
    ];
    return EkycStepper(
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
    );
  }
}
