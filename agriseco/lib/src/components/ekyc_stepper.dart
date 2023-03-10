import 'package:flutter/material.dart';
import '../constants.dart';

enum EkycStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a tick icon in its circle.
  complete,
}

class EkycStep extends StatelessWidget {
  const EkycStep({
    required this.content,
    required this.state,
    // @required this.bottomButtonState,
    // @required this.bottomButtonStateChange,
  });

  final Widget content;
  final EkycStepState state;
  // final bool bottomButtonState;
  // final ValueChanged<bool> bottomButtonStateChange;

  @override
  Widget build(BuildContext context) {
    return content;
  }
}

class EkycStepper extends StatefulWidget {
  const EkycStepper({
    required this.ekycSteps,
    this.onStepTapped,
    this.currentStep,
    this.onStepContinue,
    required this.isShowBottomButton,
  });

  final List<EkycStep> ekycSteps;
  final int? currentStep;

  final ValueChanged<int>? onStepTapped;
  final VoidCallback? onStepContinue;

  final bool? isShowBottomButton;

  @override
  State<EkycStepper> createState() => _EkycStepperState();
}

class _EkycStepperState extends State<EkycStepper> {
  final Map<int, EkycStepState> _stepStates = {};
  bool? isShowBottomButton;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.ekycSteps.length; i++) {
      _stepStates[i] = widget.ekycSteps[i].state;
    }
  }

  @override
  void didUpdateWidget(covariant EkycStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    for (int i = 0; i < widget.ekycSteps.length; i++) {
      if (i <= widget.currentStep!) {
        _stepStates[i] = EkycStepState.complete;
      } else {
        _stepStates[i] = EkycStepState.indexed;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: kBackgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: _HeaderProcess(
            stepTotal: widget.ekycSteps.length,
            onStepTab: widget.onStepTapped,
            stepStates: _stepStates,
          ),
        ),
        Expanded(
          child: widget.ekycSteps[widget.currentStep!].content,
        ),
        _BottomButton(
          nextPage: widget.onStepContinue,
          isShow: widget.isShowBottomButton,
          buttonLabel: 'Ti???p t???c',
        ),
      ],
    );
  }
}

class _HeaderProcess extends StatefulWidget {
  _HeaderProcess({
    required this.stepTotal,
    required this.onStepTab,
    required this.stepStates,
  });

  final int stepTotal;
  final ValueChanged<int>? onStepTab;
  final Map<int, EkycStepState> stepStates;

  @override
  State<_HeaderProcess> createState() => _HeaderProcessState();
}

class _HeaderProcessState extends State<_HeaderProcess> {
  int editingIndex() {
    int result = 0;

    for (int i = 0; i < this.widget.stepStates.length; i++) {
      if (this.widget.stepStates[i] == EkycStepState.complete) {
        result = i;
      }
    }
    return result;
  }

  bool _isLast(int index) {
    return widget.stepTotal == index + 1;
  }

  Widget _buildCircleStep({required int stepIndex}) {
    EkycStepState? state = this.widget.stepStates[stepIndex];

    // if (editingIndex() - stepIndex == 1) {}
    switch (state) {
      case EkycStepState.complete:
        return GestureDetector(
          onTap: () {
            this.widget.onStepTab?.call(
                editingIndex() - stepIndex == 1 ? stepIndex : editingIndex());
          },
          child: Container(
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: kCompleteStepCircleTextStyle,
              ),
            ),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                color: kYellowColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: kYellowColor,
                  style: BorderStyle.solid,
                )),
          ),
        );

      case EkycStepState.indexed:
      default:
        return GestureDetector(
          onTap: () {
            this.widget.onStepTab?.call(
                editingIndex() - stepIndex == 1 ? stepIndex : editingIndex());
          },
          child: Container(
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: kIncompleteStepCircleTextStyle,
              ),
            ),
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                color: kBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: kYellowColor,
                  style: BorderStyle.solid,
                )),
          ),
        );
    }
  }

  Widget _buildCircleStepChain() {
    List<Widget> children = [
      for (int i = 0; i < widget.stepTotal; i++) ...<Widget>[
        _buildCircleStep(stepIndex: i),
        if (!_isLast(i))
          Expanded(
            child: Container(
              color: kYellowColor,
              margin: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              height: 1,
            ),
          )
      ]
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: children,
      ),
    );
  }

  Widget _buildProcessHeader() {
    return _buildCircleStepChain();
  }

  @override
  Widget build(BuildContext context) {
    return _buildProcessHeader();
  }
}

class _BottomButton extends StatelessWidget {
  _BottomButton({
    required this.nextPage,
    required this.buttonLabel,
    required this.isShow,
  });

  final String buttonLabel;
  final Function? nextPage;
  final bool? isShow;

  @override
  Widget build(BuildContext context) {
    return isShow!
        ? GestureDetector(
            onTap: () {
              nextPage!();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
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
              child: SafeArea(
                  child: Center(
                      child: Text(buttonLabel, style: kLabelButtonStyle))),
            ),
          )
        : Container();
  }
}
