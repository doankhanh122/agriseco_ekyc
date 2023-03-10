import 'package:flutter/material.dart';

import '../../components/shared/detail_row_with_circle_lead.dart';

class Content1 extends StatelessWidget {
  const Content1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '2. Vui lòng chuẩn bị:',
              style: TextStyle().copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        DetailRowWithCircleLead(
          child: Text('CMND hoặc CCCD còn hiệu lực theo quy định.'),
        ),
        DetailRowWithCircleLead(
          child: Flexible(
            child:
                Text('Máy tính hoặc Điện thoại có Camera. Kiểm tra TẠI ĐÂY.'),
          ),
        ),
        DetailRowWithCircleLead(
          child: Flexible(
            child: Text(
                'Điện thoại di động để nhận mật khẩu OTP và email để nhận thông tin, hồ sơ mở tài khoản.'),
          ),
        ),
        Row(
          children: [
            Text(
              '3. Hướng dẫn sử dụng:',
              style: TextStyle().copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        DetailRowWithCircleLead(
          child: Flexible(
            child: Text(
                'Vui lòng xem hướng dẫn mở tài khoản và các chính sách ưu đãi TẠI ĐÂY.'),
          ),
        ),
        DetailRowWithCircleLead(
          child: Flexible(
            child: Text('Quý khách cần hỗ trợ xin gọi số 1900 5555 82'),
          ),
        ),
      ],
    );
  }
}
