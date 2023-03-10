import 'package:flutter/material.dart';

class Content4 extends StatelessWidget {
  const Content4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                '2. Không cần ra quầy - Không phí đăng ký - Không phí chuyển tiền:',
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
