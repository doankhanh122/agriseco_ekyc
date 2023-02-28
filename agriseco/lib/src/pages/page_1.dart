import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/constants.dart';
import 'package:agriseco/src/pages/contents/content_3.dart';
import 'package:flutter/material.dart';
import 'contents/content_1.dart';
import 'contents/content_2.dart';
import 'contents/content_4.dart';

@immutable
class FirstPage extends StatefulWidget {
  FirstPage(
      {this.choices,
      this.isShowBottomButtonCallback,
      this.isAgribankChoicedCallback});
  final List<AccountChoice> choices;
  final ValueChanged<bool> isShowBottomButtonCallback;
  final ValueChanged<bool> isAgribankChoicedCallback;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<AccountChoice> choices = [
    AccountChoice(
      accountType: 'Nhà đầu tư cá nhân trong nước',
      isSelected: true,
    ),
    AccountChoice(
      accountType: 'Nhà đầu tư cá nhân nước ngoài',
      isSelected: false,
    ),
    AccountChoice(
      accountType: 'Tổ chức trong nước',
      isSelected: false,
    ),
    AccountChoice(
      accountType: 'Tổ chức nước ngoài',
      isSelected: false,
    ),
    AccountChoice(
      accountType: 'Người giới thiệu mở tài khoản',
      isSelected: false,
    ),
    AccountChoice(
      accountType: 'Nhà đầu tư là CBNV Agribank',
      isSelected: false,
    ),
    AccountChoice(
        accountType: 'Nhà đầu tư cá nhân có tài khoản Agribank',
        isSelected: false),
    AccountChoice(
      accountType: 'Nhà đầu tư muốn mở tài khoản Agribank',
      isSelected: false,
    ),
  ];
  int currentSelected = 0;
  void _onChoiceTab(int index) {
    // Check can go to next Page
    if ([1, 2, 3, 7].contains(index)) {
      widget.isShowBottomButtonCallback.call(false);
    } else {
      widget.isShowBottomButtonCallback.call(true);
    }

    if (index == 5) {
      widget.isAgribankChoicedCallback.call(true);
    } else {
      widget.isAgribankChoicedCallback.call(false);
    }
    //
    setState(() {
      currentSelected = index;
      for (int i = 0; i < choices.length; i++) {
        choices[i].isSelected = i == index ? true : false;
      }
    });
  }

  Widget _renderChoicedContent(int index) {
    switch (index) {
      case 1:
      case 2:
      case 3:
        return Content2();
        break;

      case 5:
        return Content3();
      case 7:
        return Content4();
        break;

      case 4:
      case 6:
      default:
        return Content1();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Mở tài khoản chứng khoán trực tuyến',
      content: Column(
        children: [
          Row(
            children: [
              Text(
                '1. Quý khách là: (*)',
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: _AccountChoices(
                choices: choices,
                onChoieTab: _onChoiceTab,
              )),
            ],
          ),
          Row(
            children: [
              Expanded(child: _renderChoicedContent(currentSelected)),
            ],
          ),
        ],
      ),
    );
  }
}

class AccountChoice {
  AccountChoice({this.isSelected, this.accountType});
  bool isSelected;
  final String accountType;
}

class _Choices extends StatelessWidget {
  const _Choices({@required this.choices, @required this.onChoiceTap});

  final List<AccountChoice> choices;
  final ValueChanged<int> onChoiceTap;
  @override
  Widget build(BuildContext context) {
    List<Widget> choiceWidgets = [
      for (int i = 0; i < choices.length; i++) ...<Widget>[
        _Choice(
          choice: choices[i],
          onAccountChoiceTap: (AccountChoice choice) {
            int index = choices.indexOf(choice);
            onChoiceTap.call(index);
          },
        ),
      ]
    ];
    return Column(
      children: choiceWidgets,
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({@required this.choice, @required this.onAccountChoiceTap});

  final AccountChoice choice;
  final ValueChanged<AccountChoice> onAccountChoiceTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onAccountChoiceTap.call(choice);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: choice.isSelected ? kYellowColor : null,
          // border: Border.all(color: kBackgroundColor, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            choice.isSelected ? _CircleSelected() : _CircleDeselected(),
            Text(choice.accountType),
          ],
        ),
      ),
    );
  }
}

class _CircleDeselected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: kPrimaryTextColor,
              style: BorderStyle.solid,
            )),
      ),
    );
  }
}

class _CircleSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
              color: kBackgroundColor,
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: kBackgroundColor,
                style: BorderStyle.solid,
              )),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 25,
      width: 25,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: kBackgroundColor,
            style: BorderStyle.solid,
          )),
    );
  }
}

class _AccountChoices extends StatelessWidget {
  const _AccountChoices({@required this.choices, @required this.onChoieTab});

  final List<AccountChoice> choices;
  final ValueChanged<int> onChoieTab;

  // List<AccountChoice> updateChoices(int index) {
  @override
  Widget build(BuildContext context) {
    return _Choices(
        choices: choices,
        onChoiceTap: (int index) {
          onChoieTab.call(index);
        });
  }
}
