import 'package:agriseco/src/components/google_ml/camera_view.dart';
import 'package:agriseco/src/components/google_ml/face_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

enum EHeadDirection {
  straight,
  left,
  right,
}

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({
    @required this.cameraIndex,
    this.smileCalculatate,
    this.headEulerAngleXCalculate,
    this.headEulerAngleYCalculate,
    this.facesCallback,
  });

  final int cameraIndex;
  final ValueChanged<double> smileCalculatate;
  final ValueChanged<double> headEulerAngleXCalculate;
  final ValueChanged<EHeadDirection> headEulerAngleYCalculate;
  final ValueChanged<List<Face>> facesCallback;

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));

  CustomPaint _customPaint;
  bool _isBusy = false;

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      cameraIndex: widget.cameraIndex,
      customPaint: _customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (_isBusy) return;
    _isBusy = true;
    setState(() {});
    final faces = await _faceDetector.processImage(inputImage);

    widget.facesCallback.call(faces);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
        faces: faces,
        absoluteImageSize: inputImage.inputImageData.size,
        rotation: inputImage.inputImageData.imageRotation,
        smileCalculate: (double smileProbability) {
          widget.smileCalculatate.call(smileProbability);
        },
        headEulerAngleX: (double value) {
          // widget.headEulerAngleXCalculate.call(value);
        },
        headEulerAngleY: (EHeadDirection value) {
          widget.headEulerAngleYCalculate.call(value);
        },
      );

      _customPaint = CustomPaint(
        painter: painter,
      );
    }

    _isBusy = false;

    if (mounted) {
      setState(() {});
    }
  }
}
