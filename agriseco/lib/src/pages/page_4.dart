import 'dart:async';

import 'package:agriseco/src/components/google_ml/face_detector_view.dart';
import 'package:agriseco/src/components/page_layout.dart';
import 'package:agriseco/src/components/shared/detail_row_with_circle_lead.dart';
import 'package:flutter/material.dart';

import '../components/google_ml/camera_view.dart';
import '../components/shared/camera_circle.dart';
import '../components/shared/countdown_widget.dart';

const String text1 = '''
Quý khách đưa khuôn mặt vào khung hình, nhìn thẳng và ngay ngắn như khi chụp ảnh thẻ, di chuyển nhẹ khuôn mặt đến khi hệ thống yêu cầu nở nụ cười, trong thời gian tiếp theo Quý khách giữ yên khuôn mặt và nhìn thẳng.
''';

class FourthPage extends StatefulWidget {
  const FourthPage({
    Key key,
    this.isShowBottomButtonCallback,
  }) : super(key: key);
  final ValueChanged<bool> isShowBottomButtonCallback;

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Xác thực khuôn mặt',
      content: Column(
        children: [
          DetailRowWithCircleLead(
            child: Flexible(
              child: Text(text1),
            ),
          ),
          DetailRowWithCircleLead(
            child: Flexible(
              child: Text(
                  'Đảm bảo đủ ánh sáng và chỉ có duy nhất khuôn mặt của quý khách trong khung hình.'),
            ),
          ),

          CameraCircle(
            cameraCapturePressed: (bool isCaptured) {
              widget.isShowBottomButtonCallback.call(isCaptured);
            },
            passedAllConditionCallback: () {
              widget.isShowBottomButtonCallback.call(true);
            },
          ),

          // SizedBox(height: 500, child: FaceDetectorView()),
        ],
      ),
    );
  }
}
