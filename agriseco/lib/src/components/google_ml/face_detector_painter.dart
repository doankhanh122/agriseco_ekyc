import 'dart:math';

import 'package:agriseco/src/components/google_ml/coordinates_translator.dart';
import 'package:agriseco/src/components/google_ml/face_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter({
    this.faces,
    this.absoluteImageSize,
    this.rotation,
    this.smileCalculate,
    this.headEulerAngleX,
    this.headEulerAngleY,
  });
  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  final ValueChanged<double> smileCalculate;
  final ValueChanged<double> headEulerAngleX;
  final ValueChanged<EHeadDirection> headEulerAngleY;

  EHeadDirection getHeadDirection(double eulerY) {
    double _rightThreadhold = 15;
    double _leftThreadhold = -15;

    EHeadDirection result;

    if (eulerY > _rightThreadhold) {
      result = EHeadDirection.right;
    } else if (eulerY < _leftThreadhold) {
      result = EHeadDirection.left;
    } else {
      result = EHeadDirection.straight;
    }
    return result;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print(faces);
    // print(absoluteImageSize);
    // print(rotation);

    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    // print(size);
    for (final Face face in faces) {
      if (face.headEulerAngleX != null)
        headEulerAngleX.call(face.headEulerAngleX);
      if (face.headEulerAngleY != null) {
        headEulerAngleY.call(getHeadDirection(face.headEulerAngleY));
      }
      // print(face.headEulerAngleY);

      // print(face.contours[FaceContourType.upperLipTop].points);

      final dx = (translateX(
                  face.boundingBox.left, rotation, size, absoluteImageSize) +
              translateX(
                  face.boundingBox.right, rotation, size, absoluteImageSize)) /
          2;

      final dy =
          translateY(face.boundingBox.top, rotation, size, absoluteImageSize) +
              (translateY(face.boundingBox.bottom, rotation, size,
                          absoluteImageSize) -
                      translateY(face.boundingBox.top, rotation, size,
                          absoluteImageSize)) *
                  0.2;

      if (face.smilingProbability != null) {
        smileCalculate.call(face.smilingProbability);
        TextSpan span = new TextSpan(
            text: 'Smile: ${face.smilingProbability.toStringAsFixed(3)}');
        TextPainter tp = new TextPainter(
            text: span,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(
          canvas,
          Offset(
            dx,
            dy,
          ),
        );
      }

      // canvas.drawRect(
      //     // Rect.fromLTRB(
      //     //   face.boundingBox.left,
      //     //   face.boundingBox.top,
      //     //   face.boundingBox.right,
      //     //   face.boundingBox.bottom,
      //     // ),
      //     Rect.fromLTRB(
      //       translateX(
      //           face.boundingBox.left, rotation, size, absoluteImageSize),
      //       translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
      //       translateX(
      //           face.boundingBox.right, rotation, size, absoluteImageSize),
      //       translateY(
      //           face.boundingBox.bottom, rotation, size, absoluteImageSize),
      //     ),
      //     paint);

      void paintContour(FaceContourType type) {
        final faceContour = face.contours[type];
        if (faceContour.points != null) {
          for (final Point point in faceContour.points) {
            canvas.drawCircle(
                Offset(
                  translateX(
                      point.x.toDouble(), rotation, size, absoluteImageSize),
                  translateY(
                      point.y.toDouble(), rotation, size, absoluteImageSize),
                ),
                1,
                paint);
          }
        }
      }

      // paintContour(FaceContourType.upperLipTop);
      // paintContour(FaceContourType.upperLipBottom);
      // paintContour(FaceContourType.lowerLipTop);
      // paintContour(FaceContourType.lowerLipBottom);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}
