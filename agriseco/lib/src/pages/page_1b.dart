import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/components/shared/custom_dropdown.dart';
import 'package:agriseco/src/components/shared/custom_textfield.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../components/shared/detail_row_with_circle_lead.dart';
import '../constants.dart';

final List<DropdownItem> _listAgribank = [
  DropdownItem(value: 1, name: 'Trung tâm thanh toán Agribank'),
  DropdownItem(value: 2, name: 'Trung tâm thẻ Agribank'),
  DropdownItem(value: 3, name: 'Trung tâm đào tạo Agribank'),
  DropdownItem(value: 1000, name: 'Trung tâm vốn'),
  DropdownItem(value: 1200, name: 'Sở Giao dịch'),
  DropdownItem(value: 1220, name: 'Long Biên'),
  DropdownItem(value: 1240, name: 'Hoàng Mai'),
  DropdownItem(value: 1260, name: 'Hồng Hà'),
  DropdownItem(value: 1300, name: 'Thăng Long'),
];

class AgribankPage extends StatefulWidget {
  const AgribankPage({
    this.isShowBottomButtonCallback,
  });
  final ValueChanged<bool> isShowBottomButtonCallback;

  @override
  State<AgribankPage> createState() => _AgribankPageState();
}

class _AgribankPageState extends State<AgribankPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Xác nhận CBNV Agribank',
      content: Column(
        children: [
          DetailRowWithCircleLead(
            child: Flexible(child: Text('Đơn vị công tác: (*)')),
            isLead: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomDropdown(
              dropDownList: _listAgribank,
            ),
          ),
          DetailRowWithCircleLead(
            child: Flexible(child: Text('Email: (*)')),
            isLead: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Text(
                  'Vui lòng nhập và kiểm tra chính xác email nội bộ Agribank để nhận mã xác thực',
                  style: kBodyItalicTextStyle,
                ),
                CustomTextField(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
