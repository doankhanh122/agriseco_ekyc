import 'package:agriseco/src/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// CameraApp is the Main Application.
class CameraCircle extends StatefulWidget {
  /// Default Constructor
  const CameraCircle({
    this.cameraCapturePressed,
  });

  final ValueChanged<bool> cameraCapturePressed;

  @override
  State<CameraCircle> createState() => _CameraCircleState();
}

class _CameraCircleState extends State<CameraCircle> {
  List<CameraDescription> _cameras = [];
  CameraController controller;
  int cameraId;

  void getCameras() async {
    _cameras = await availableCameras();
    controller = CameraController(
      _cameras[cameraId],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
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
    // getCameras();

    cameraId = 1;
    getCameras();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_cameras.isEmpty)
      return TextButton(
        child: Text('Cameras'),
      );
    if (!controller.value.isInitialized) {
      return TextButton(
        child: Text('Cameras'),
      );
    } else {
      return Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          ClipOval(
            clipper: _CameraCircleClipper(),
            child: ClipRRect(
              // clipper: _CameraFrameClipper(),
              child: Container(
                child: CameraPreview(controller),
              ),
            ),
          ),
          Positioned(
            top: size.width * 0.9 * 3 / 4 + 8,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            cameraId = cameraId == 0 ? 1 : 0;
                            widget.cameraCapturePressed.call(false);
                          });
                          getCameras();
                        },
                        child: Icon(
                          Icons.flip_camera_ios_sharp,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.rotate_right_outlined,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.pausePreview();
                    widget.cameraCapturePressed.call(true);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kBackgroundColor),
                      padding: MaterialStateProperty.all(EdgeInsets.all(8))),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      Text(' Chụp hính'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      //   height: size.height * 0.3,
      // width: size.width * 0.9,
      // return Center(
      //   child: SizedBox(
      //     height: size.height * 0.3,
      //     width: size.width * 0.9,
      //     child: AspectRatio(
      //       aspectRatio: controller.value.aspectRatio,
      //       child: CameraPreview(controller),
      //     ),
      //   ),
      // );
    }
    //   return ClipRect(
    //     child: Container(
    //       height: 50,
    //       width: 50,
    //       child: Transform.scale(
    //         scale: controller.value.aspectRatio / size.aspectRatio,
    //         child: Center(
    //           child: AspectRatio(
    //             aspectRatio: controller.value.aspectRatio,
    //             child: CameraPreview(controller),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    // return MaterialApp(
    //   home: CameraPreview(controller),
    // );
  }
}

// controller = CameraController(
// _cameras[1],
// ResolutionPreset.max,
// imageFormatGroup: ImageFormatGroup.yuv420,
// );
// controller.initialize().then((_) {
// if (!mounted) {
// return;
// }
// setState(() {});
// }).catchError((Object e) {
// if (e is CameraException) {
// switch (e.code) {
// case 'CameraAccessDenied':
// // Handle access errors here.
// break;
// default:
// // Handle other errors here.
// break;
// }
// }
// });
class _CameraCircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width / 2, size.width * 0.4 + 10),
        radius: size.width * 0.4);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class _CameraFrameClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    RRect rect = RRect.fromLTRBR(
      size.width * 0.05,
      8,
      size.width * 0.95,
      size.width * 0.9 * 3 / 4,
      Radius.circular(40),
    );
    // RRect rect = RRect.fromRectAndRadius(
    //     Rect.fromCircle(
    //         center: Offset(size.width / 2, size.height / 2),
    //         radius: size.width * 0.4),
    //     Radius.circular(size.width * 0.2));
    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}
