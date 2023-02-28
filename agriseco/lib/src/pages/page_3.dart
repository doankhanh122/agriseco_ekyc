import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/components/shared/camera_rect.dart';
import 'package:agriseco/src/components/shared/detail_row_with_circle_lead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({
    Key key,
    this.isShowBottomButtonCallback,
  }) : super(key: key);
  final ValueChanged<bool> isShowBottomButtonCallback;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Chụp mặt sau CMND/CCCD',
      content: Column(
        children: [
          DetailRowWithCircleLead(
            child: Flexible(
              child: Text(
                  'Vui lòng chụp sao cho các cạnh sát với khung hình nhất có thể.'),
            ),
          ),
          DetailRowWithCircleLead(
            child: Flexible(
              child: Text('Tránh rung tay, lóe sáng khi chụp.'),
            ),
          ),
          CameraRect(cameraCapturePressed: (bool isCaptured) {
            widget.isShowBottomButtonCallback.call(isCaptured);
          }),
        ],
      ),
    );
  }
}
