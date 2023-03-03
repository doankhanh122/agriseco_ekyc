import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {this.customPaint, this.onImage, @required this.cameraIndex});

  final CustomPaint customPaint;
  final Function(InputImage inputImage) onImage;
  final int cameraIndex;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController _controller;
  bool _changingCameraLens = false;
  List<CameraDescription> cameras = [];
  int _cameraIndex;

  Future<List<CameraDescription>> getCameras() async {
    cameras = await availableCameras();
  }

  Future _stopLiveFeed() async {
    await _controller.dispose();
    _controller = null;
  }

  Future _startLiveFeed() async {
    await getCameras();
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
      enableAudio: false,
    );

    _controller.initialize().then((value) {
      if (!mounted) return;

      _controller.startImageStream(_processCameraImage);

      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        print(e.code);
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            print('Camera is needd!');
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _cameraIndex = widget.cameraIndex;
    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameras.isEmpty) return Text('Cameras');
    if (!_controller.value.isInitialized) {
      return Text('Cameras');
    } else {
      Size size = MediaQuery.of(context).size;
      // var scale = size.aspectRatio * _controller.value.aspectRatio;
      //
      // if (scale < 1) scale = 1 / scale;

      return Container(
        // height: size.height,
        // width: size.width,
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: CameraPreview(_controller),
            ),
            if (widget.customPaint != null) widget.customPaint,
          ],
        ),
      );
    }
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];

    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);

    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);

    if (inputImageFormat == null) return;

    final planData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
