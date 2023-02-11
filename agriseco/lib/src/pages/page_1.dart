import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      content: Column(
        children: [
          Text(
            'Mở tài khoản chứng khoán trực tuyến',
            style: kTileStyle,
          ),
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
              Expanded(child: _buildAccountChoices()),
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

class _renderChoices extends StatelessWidget {
  const _renderChoices({@required this.choices, @required this.onChoiceTap});

  final List<AccountChoice> choices;
  final ValueChanged<int> onChoiceTap;
  @override
  Widget build(BuildContext context) {
    List<Widget> choiceWidgets = [
      for (int i = 0; i < choices.length; i++) ...<Widget>[
        _renderChoice(
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

class _renderChoice extends StatelessWidget {
  const _renderChoice(
      {@required this.choice, @required this.onAccountChoiceTap});

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
            choice.isSelected ? _circleSelected() : _circleDeselected(),
            Text(choice.accountType),
          ],
        ),
      ),
    );
  }
}

class _circleDeselected extends StatelessWidget {
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

class _circleSelected extends StatelessWidget {
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

class _buildAccountChoices extends StatefulWidget {
  @override
  State<_buildAccountChoices> createState() => _buildAccountChoicesState();
}

class _buildAccountChoicesState extends State<_buildAccountChoices> {
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

  void _onChoiceTab(int index) {
    setState(() {
      for (int i = 0; i < choices.length; i++) {
        choices[i].isSelected = i == index ? true : false;
      }
    });
  }

  // List<AccountChoice> updateChoices(int index) {
  @override
  Widget build(BuildContext context) {
    return _renderChoices(
        choices: choices,
        onChoiceTap: (int index) {
          _onChoiceTab(index);
        });
  }
}
