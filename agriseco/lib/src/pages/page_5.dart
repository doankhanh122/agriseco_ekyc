import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/components/shared/custom_dropdown.dart';
import 'package:agriseco/src/components/shared/custom_textfield.dart';
import 'package:agriseco/src/components/shared/detail_row_with_circle_lead.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class FifthPage extends StatefulWidget {
  const FifthPage({Key? key, this.isDisableBottomBtn});
  final ValueChanged<bool>? isDisableBottomBtn;

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  bool? _isMale;

  @override
  void initState() {
    _isMale = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Thông tin đăng ký mở tài khoản',
      content: Column(
        children: [
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
          _PieceInfo(
            title: 'Họ và tên (*)',
            value: 'ĐOÀN NGỌC KHÁNH',
          ),
          _PieceInfo(
            title: 'Số CMND/CCCD: (*)',
            value: '012345678901',
          ),
          _PieceInfo(
            title: 'Ngày cấp: (*)',
            value: '29/04/2021',
          ),
          _PieceInfo(
            title: 'Nơi cấp: (*)',
            value: 'CỤC CẢNH SÁT QUẢN LÝ HÀNH CHÍNH VỀ TRẬT TỰ XÃ HỘI',
          ),
          _PieceInfo(
            title: 'Ngày hết hạn: (*)',
            desc: 'CCCD có giá trị đến ngày hết hạn',
            value: '12/02/2034',
          ),
          _PieceInfo(
            title: 'Ngày sính: (*)',
            value: '12/02/1994',
          ),
          _PieceInfo(
            title: 'Nơi thường trú: (*)',
            value: '151 Thái Hà, Đống Đa, TP. Hà Nội',
          ),
          _NewPieceInfo(
            title: 'Giới tính',
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  _CircleChoice(
                    isChoiced: _isMale,
                    name: 'Nam',
                    onTab: () {
                      setState(() {
                        if (!_isMale!) _isMale = !_isMale!;
                      });
                    },
                  ),
                  _CircleChoice(
                    isChoiced: !_isMale!,
                    name: 'Nữ',
                    onTab: () {
                      setState(() {
                        if (_isMale!) _isMale = !_isMale!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          _NewPieceInfo(
            title: 'Địa chỉ liên hệ: (*)',
            desc: 'Vui lòng chỉnh sửa đúng địa chỉ đang cư trú của quý khách',
            child: CustomTextField(),
          ),
          _NewPieceInfo(
            title: 'Số điện thoại (*)',
            child: CustomTextField(),
          ),
          _NewPieceInfo(
            title: 'Email: (*)',
            desc:
                'Vui lòng nhập và kiểm tra email chính xác để thuận tiện trong việc hoàn tất hồ sơ mở tài khoản',
            child: CustomTextField(),
          ),
          Row(
            children: [
              Text(
                '2. Nơi giao dịch: (*)',
                style: kBodyBoldTextStyle,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomDropdown(
              dropDownList: [
                DropdownItem(name: 'Trụ sở chính', value: 1),
                DropdownItem(name: 'Chi nhánh Miền Bắc', value: 2),
                DropdownItem(name: 'Chi nhánh Miền Trung', value: 3),
                DropdownItem(name: 'Chi nhánh Miền Nam', value: 4),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '3. Đăng ký sử dụng dịch vụ: ',
                style: kBodyBoldTextStyle,
              ),
            ],
          ),
          CheckboxInfo(
            enable: false,
            value: true,
            name: 'Giao dịch điện tử',
          ),
          CheckboxInfo(
            enable: true,
            value: false,
            name: 'Giao dịch điện tử',
          ),
          CheckboxInfo(
            enable: true,
            value: false,
            name: 'Ứng trước tiền bán chứng khoán',
          ),
          CheckboxInfo(
            enable: true,
            value: false,
            name: 'Chuyển tiền trực tuyến',
          ),
          CheckboxInfo(
            enable: true,
            value: false,
            name: 'Người giới thiệu/CSPTDV',
          ),
          CheckboxInfo(
            enable: true,
            value: false,
            name: 'Nhân viên chăm sóc',
          ),
          Row(
            children: [
              Text(
                '4. Điều khoản dịch vụ: ',
                style: kBodyBoldTextStyle,
              ),
            ],
          ),
          CheckboxInfo(
            enable: true,
            value: false,
            name:
                'Tôi đồng ý với Điều khoản và điều kiện giao dịch chứng khoán của Agriseco. Xem',
          ),
        ],
      ),
    );
  }
}

class _PieceInfo extends StatelessWidget {
  const _PieceInfo({
    required this.title,
    this.desc = '',
    required this.value,
  });

  final String title;
  final String desc;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title),
            ],
          ),
          desc != ''
              ? Text(
                  desc,
                  style: kBodyItalicTextStyle,
                )
              : Container(),
          CustomTextField(
            enable: false,
            initialValue: value,
          ),
        ],
      ),
    );
  }
}

class _NewPieceInfo extends StatelessWidget {
  const _NewPieceInfo({
    required this.title,
    this.desc = '',
    required this.child,
  });
  final String title;
  final String desc;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title),
                  ],
                ),
                desc != ''
                    ? Text(
                        desc,
                        style: kBodyItalicTextStyle,
                      )
                    : Container(),
                Container(
                  color: kGreenColor,
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleChoice extends StatelessWidget {
  const _CircleChoice(
      {required this.name, this.isChoiced = false, required this.onTab});
  final String name;
  final bool? isChoiced;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab();
      },
      child: Row(
        children: [
          Container(
            child: Center(
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: isChoiced! ? kYellowColor : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 8),
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: isChoiced! ? 8 : 1,
                  color: isChoiced! ? kBackgroundColor : Colors.black87,
                  style: BorderStyle.solid,
                )),
          ),
          Text(name),
        ],
      ),
    );
  }
}

class CheckboxInfo extends StatefulWidget {
  CheckboxInfo({this.enable, this.name, this.value, this.onChange});

  final bool? enable;
  final String? name;
  final bool? value;
  final ValueChanged<bool>? onChange;

  @override
  State<CheckboxInfo> createState() => _CheckboxInfoState();
}

class _CheckboxInfoState extends State<CheckboxInfo> {
  bool? _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: _value,
            onChanged: (bool? value) {
              if (widget.enable!) {
                setState(() {
                  _value = value;
                });
              }
            },
            checkColor: widget.enable! ? Colors.white : Colors.black38,
            fillColor: widget.enable!
                ? MaterialStateProperty.all(Colors.black38)
                : MaterialStateProperty.all(Colors.grey.shade300),
          ),
        ),
        Flexible(child: Text(widget.name!)),
      ],
    );
  }
}
