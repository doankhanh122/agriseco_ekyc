import 'package:agriseco/src/components/shared/detail_row_with_circle_lead.dart';
import 'package:agriseco/src/constants.dart';
import 'package:flutter/material.dart';

class Content2 extends StatelessWidget {
  const Content2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                '2. Quý khách hàng vui lòng đăng ký tài khoản tại đây:',
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        AddressDetail(
          name: 'TRỤ SỞ CHÍNH',
          address: 'Tầng 5 - Tòa nhà Artex - 172 Ngọc Khánh - Ba Đình - Hà Nội',
          phone: '024.62762666',
        ),
        AddressDetail(
          name: 'CHI NHÁNH MIỀN BẮC',
          address: 'Tầng 5 - Tòa nhà Artex - 172 Ngọc Khánh - Ba Đình - Hà Nội',
          phone: '024.62762666',
        ),
        AddressDetail(
          name: 'CHI NHÁNH MIỀN TRUNG',
          address: 'Tầng 5 - Tòa nhà Artex - 172 Ngọc Khánh - Ba Đình - Hà Nội',
          phone: '024.62762666',
        ),
        AddressDetail(
          name: 'CHI NHÁNH MIỀN NAM',
          address: 'Tầng 5 - Tòa nhà Artex - 172 Ngọc Khánh - Ba Đình - Hà Nội',
          phone: '024.62762666',
        ),
      ],
    );
  }
}

class AddressDetail extends StatelessWidget {
  const AddressDetail(
      {@required this.name, @required this.address, @required this.phone});

  final String name;
  final String address;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1.5,
          color: kBackgroundColor,
        ),
      )),
      child: Column(
        children: [
          Container(
            color: kBackgroundColor,
            child: DetailRowWithCircleLead(
              child: Flexible(
                child: Text(
                  '${name.toUpperCase()}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              isLead: false,
            ),
          ),
          DetailRowWithCircleLead(
            child: Flexible(child: Text('Địa chỉ: $address')),
            isLead: false,
          ),
          DetailRowWithCircleLead(
            child: Flexible(child: Text('Điện thoại: $phone')),
            isLead: false,
          ),
        ],
      ),
    );
  }
}
