library agriseco;

import 'package:agriseco/src/components/ekyc_stepper.dart';
import 'package:agriseco/src/constants.dart';
import 'package:agriseco/src/pages/page_1b.dart';
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
      // isShowBottomButtonStates[i] =
      //     i == index ? newValue : (i == 0 ? true : false);

      if (i == index) {
        isShowBottomButtonStates[i] = newValue;
      } else {
        switch (i) {
          case 0:
          case 4:
            isShowBottomButtonStates[i] = true;
            break;

          default:
            isShowBottomButtonStates[i] = false;
        }
      }
    }
  }

  //Khi KH la CBNV AGRIBANK. them 1 Step xác nhận email, đơn vị công tác
  //đồng thời update lại trạng tái BottomButton (Tiếp tục)
  //Khởi tạo step
  List<EkycStep> makingSteps({bool isAgribank}) {
    int a = isAgribank ? 1 : 0;
    List<EkycStep> result = [];
    result = [
      EkycStep(
        content: FirstPage(
          isShowBottomButtonCallback: (bool value) {
            updateBottomButtonStates(index: 0, newValue: value);
            setState(() {});
          },
          // Chọn là khách hàng Agribank để kích hoạt sự kiện
          isAgribankChoicedCallback: (bool value) {
            setState(() {
              steps = makingSteps(isAgribank: value);
            });
          },
        ),
        state: EkycStepState.complete,
      ),
      EkycStep(
        content: SecondPage(isShowBottomButtonCallback: (bool value) {
          print(value);
          setState(() {
            updateBottomButtonStates(index: a + 1, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: ThirdPage(isShowBottomButtonCallback: (bool value) {
          setState(() {
            updateBottomButtonStates(index: a + 2, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: FourthPage(isShowBottomButtonCallback: (bool value) {
          setState(() {
            updateBottomButtonStates(index: a + 3, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: FifthPage(isDisableBottomBtn: (bool value) {
          setState(() {
            updateBottomButtonStates(index: a + 4, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
      EkycStep(
        content: SixthPage(isDisableBottomBtn: (bool value) {
          setState(() {
            updateBottomButtonStates(index: a + 5, newValue: value);
          });
        }),
        state: EkycStepState.indexed,
      ),
    ];

    // Khi KH la CBNV, kich hoat thêm step
    if (isAgribank) {
      result.insert(
          1,
          EkycStep(
            content: AgribankPage(isShowBottomButtonCallback: (bool value) {
              setState(() {
                updateBottomButtonStates(index: 1, newValue: value);
              });
            }),
            state: EkycStepState.complete,
          ));
    }

    return result;
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 7; i++) {
      isShowBottomButtonStates[i] = i == 0 ? true : false;
    }

    steps = makingSteps(isAgribank: false);
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: EkycStart(
          steps: steps,
          isShowBottomButtonStates: isShowBottomButtonStates,
          stepTappedCallBack: (int stepIndex) {
            setState(() {
              // Nếu quay trở về tap đầu tiên, reset lại các Steps về mặc định
              if (stepIndex == 0) steps = makingSteps(isAgribank: false);
            });
          },
        ),
      ),
    );
  }
}

class EkycStart extends StatefulWidget {
  const EkycStart(
      {this.isShowBottomButtonStates, this.steps, this.stepTappedCallBack});

  final Map<int, bool> isShowBottomButtonStates;
  final List<EkycStep> steps;
  final ValueChanged<int> stepTappedCallBack;

  @override
  State<EkycStart> createState() => _EkycStartState();
}

class _EkycStartState extends State<EkycStart> {
  int currentIndex = 3;

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
        widget.stepTappedCallBack.call(index);
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
