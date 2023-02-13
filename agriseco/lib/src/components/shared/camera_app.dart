import 'package:agriseco/src/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   _cameras = await availableCameras();
//   runApp(const CameraApp());
// }

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp();

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
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
    cameraId = 0;
    getCameras();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            clipper: _CameraFrameClipper(),
            child: Container(
              child: CameraPreview(controller),
            ),
          ),
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
class _CameraFrameClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    RRect rect = RRect.fromLTRBR(
      size.width * 0.05,
      size.height * 0.1,
      size.width * 0.95,
      size.height * 0.5,
      Radius.circular(40),
    );
    // Rect rect = Rect.fromLTRB(
    //   size.width * 0.05,
    //   size.height * 0.3,
    //   size.width * 0.95,
    //   size.height * 0.7,
    // );

    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
    return false;
  }
}
