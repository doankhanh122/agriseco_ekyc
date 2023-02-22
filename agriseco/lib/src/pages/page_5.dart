import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/components/shared/custom_textfield.dart';
import 'package:agriseco/src/components/shared/detail_row_with_circle_lead.dart';
import 'package:flutter/material.dart';

import '../../agriseco.dart';
import '../constants.dart';

class FifthPage extends StatelessWidget {
  const FifthPage({Key key, this.isDisableBottomBtn});
  final ValueChanged<bool> isDisableBottomBtn;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Text(
              'Thông tin đăng ký mở tài khoản',
              style: kTileStyle,
            ),
          ),
          Row(
            children: [
              Text(
                '1. Thông tin người mở tài khoản:',
                style: kBodyBoldTextStyle,
              ),
            ],
          ),
          DetailRowWithCircleLead(
            child: Flexible(
                child: Text(
                    'Vui lòng kiểm tra kỹ thông tin cá nhân. Nếu có sai sót, vui lòng ấn VÀO ĐÂY để sửa')),
          ),
          PieceInfo(
            title: 'Họ và tên (*)',
            value: 'ĐOÀN NGỌC KHÁNH',
          ),
          PieceInfo(
            title: 'Họ và tên (*)',
            value: 'ĐOÀN NGỌC KHÁNH',
          ),
        ],
      ),
    );
  }
}

class PieceInfo extends StatelessWidget {
  const PieceInfo({@required this.title, @required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(title),
            ],
          ),
          CustomTextField(
            enable: false,
            initialValue: value,
          ),
        ],
      ),
    );
  }
}
