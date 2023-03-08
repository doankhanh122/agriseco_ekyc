import 'package:agriseco/src/components/google_ml/face_detector_view.dart';
import 'package:agriseco/src/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class StepFaceDetection {
  final int number;
  final bool status;
  final String text;

  StepFaceDetection(this.number, this.status, this.text);
}

///
///
///
class CameraCircle extends StatefulWidget {
  /// Default Constructor
  const CameraCircle({
    this.cameraCapturePressed,
    this.passedAllConditionCallback,
  });

  final ValueChanged<bool> cameraCapturePressed;
  final VoidCallback passedAllConditionCallback;

  @override
  State<CameraCircle> createState() => _CameraCircleState();
}

class _CameraCircleState extends State<CameraCircle> {
  List<CameraDescription> _cameras = [];
  CameraController controller;
  int cameraId;

  ValueNotifier<bool> _isSmileNotifier = ValueNotifier(false);
  ValueNotifier<List<Face>> _facesNotifier = ValueNotifier([]);
  ValueNotifier<EHeadDirection> _headAngleNotifier =
      ValueNotifier(EHeadDirection.straight);

  bool _didSmile = false;
  ValueNotifier<bool> _reset = ValueNotifier(false);

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

    // Future.delayed(Duration(seconds: 3), () {
    //   setState(() {
    //     _didSmile = true;
    //   });
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_cameras.isEmpty) return Text('Cameras');
    if (!controller.value.isInitialized) {
      return Text('Cameras');
    } else {
      return Column(
        children: [
          !_didSmile
              ? _DirectionTitle(
                  reset: _reset,
                  smileNotifier: _isSmileNotifier,
                  facesNotifier: _facesNotifier,
                  headNotifier: _headAngleNotifier,
                  allConditionPassed: () {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      widget.passedAllConditionCallback.call();
                      setState(() {
                        _didSmile = true;
                      });
                    });
                  },
                )
              : Container(),
          // isSmile.value ? Text('Smiling') : Text('Smile please!'),

          Stack(
            clipBehavior: Clip.antiAlias,
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                width: size.width,
                height: size.width * 0.70 + 16,
              ),
              Positioned(
                top: -size.height * 0.5 + size.width * 0.35 + 8,
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Align(
                        child: ClipOval(
                          clipper: _CameraCircleClipper(),
                          child: FaceDetectorView(
                            cameraIndex: cameraId,
                            smileCalculatate: (double smileProbability) {
                              // print('Camera: $smileProbability');
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                _isSmileNotifier.value = smileProbability > 0.7;
                              });
                            },
                            headEulerAngleXCalculate: (double value) {
                              // bool r = value < -10.0;
                              // print(r.toString());
                            },
                            facesCallback: (List<Face> faces) {
                              _facesNotifier.value = faces;
                            },
                            headEulerAngleYCalculate:
                                (EHeadDirection headDirection) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                _headAngleNotifier.value = headDirection;
                              });
                            },
                          ),
                          // child: CameraPreview(
                          //   controller,
                          // ),
                        ),
                      ),
                    ),
                    // ClipOval(
                    //   clipper: _CameraCircleClipper(),
                    //   child: CameraPreview(
                    //     controller,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Positioned(
              //   top: size.width * 0.7 + 8,
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Colors.white,
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.grey.withOpacity(0.5),
              //                     spreadRadius: 5,
              //                     blurRadius: 7,
              //                     offset: Offset(0, 3),
              //                   ),
              //                 ]),
              //             child: TextButton(
              //               onPressed: () {
              //                 setState(() {
              //                   cameraId = cameraId == 0 ? 1 : 0;
              //                   widget.cameraCapturePressed.call(false);
              //                 });
              //                 getCameras();
              //               },
              //               child: Icon(
              //                 Icons.flip_camera_ios_sharp,
              //                 color: Colors.black54,
              //               ),
              //             ),
              //           ),
              //           Container(
              //             decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Colors.white,
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.grey.withOpacity(0.5),
              //                     spreadRadius: 5,
              //                     blurRadius: 7,
              //                     offset: Offset(0, 3),
              //                   ),
              //                 ]),
              //             child: TextButton(
              //               onPressed: () {},
              //               child: Icon(
              //                 Icons.rotate_right_outlined,
              //                 color: Colors.black54,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       // SizedBox(
              //       //   height: 8,
              //       // ),
              //       // ElevatedButton(
              //       //   onPressed: () {
              //       //     controller.pausePreview();
              //       //     widget.cameraCapturePressed.call(true);
              //       //   },
              //       //   style: ButtonStyle(
              //       //       backgroundColor:
              //       //           MaterialStateProperty.all(kBackgroundColor),
              //       //       padding: MaterialStateProperty.all(EdgeInsets.all(8))),
              //       //   child: Row(
              //       //     children: [
              //       //       Icon(Icons.camera_alt_outlined),
              //       //       Text(' Chụp hính'),
              //       //     ],
              //       //   ),
              //       // ),
              //     ],
              //   ),
              // ),

              // Circle Custom Paint
              SizedBox(
                width: size.width * 0.7,
                height: size.width * 0.7,
                child: CustomPaint(
                  painter: CirclePainter(
                      color: _didSmile ? Colors.green : Colors.red),
                ),
              ),
            ],
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
              onPressed: () {
                if (!_reset.value) _reset.value = true;
                getCameras();
                if (_reset.value) _reset.value = false;

                setState(() {
                  cameraId = cameraId == 0 ? 1 : 0;
                  widget.cameraCapturePressed.call(false);
                });
              },
              child: Icon(
                Icons.flip_camera_ios_sharp,
                color: Colors.black54,
              ),
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
        center: Offset(size.width * 0.5, size.height * 0.5),
        radius: size.width * 0.35);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}

// class _CameraFrameClipper extends CustomClipper<RRect> {
//   @override
//   RRect getClip(Size size) {
//     RRect rect = RRect.fromLTRBR(
//       size.width * 0.05,
//       8,
//       size.width * 0.95,
//       size.width * 0.9 * 3 / 4,
//       Radius.circular(40),
//     );
//     // RRect rect = RRect.fromRectAndRadius(
//     //     Rect.fromCircle(
//     //         center: Offset(size.width / 2, size.height / 2),
//     //         radius: size.width * 0.4),
//     //     Radius.circular(size.width * 0.2));
//     return rect;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<RRect> oldClipper) {
//     return false;
//   }
// }

class _DirectionTitle extends StatelessWidget {
  const _DirectionTitle({
    @required this.smileNotifier,
    @required this.facesNotifier,
    @required this.headNotifier,
    this.allConditionPassed,
    @required this.reset,
  });

  final ValueNotifier<bool> smileNotifier;
  final ValueNotifier<List<Face>> facesNotifier;
  final ValueNotifier<EHeadDirection> headNotifier;
  final VoidCallback allConditionPassed;
  final ValueNotifier<bool> reset;

  @override
  Widget build(BuildContext context) {
    bool _didSmile = false, _didTurnLeft = false, _didTurnRight = false;
    return AnimatedBuilder(
      animation:
          Listenable.merge([smileNotifier, facesNotifier, headNotifier, reset]),
      builder: (BuildContext context, Widget child) {
        int _facesCount = facesNotifier.value.length;
        bool isSmile = smileNotifier.value;
        EHeadDirection _headAngle = headNotifier.value;

        print(reset.value);
        if (reset.value) {
          _didSmile = false;
          _didTurnLeft = false;
          _didTurnRight = false;
        }

        Widget _headCondition(EHeadDirection value) {
          if (value == EHeadDirection.straight && !_didTurnLeft) {
            return DirectionAlert(
              text: 'Hãy quay đầu sang trái',
            );
          } else if (value == EHeadDirection.left && !_didTurnRight) {
            _didTurnLeft = true;
            return DirectionAlert(
              text: 'Hãy quay đầu sang phải',
            );
          } else if (value == EHeadDirection.right && _didTurnLeft) {
            _didTurnRight = true;
          }
          if (_didTurnLeft && _didTurnRight) {
            allConditionPassed.call();
            return Text('OK');
          }

          return DirectionAlert(
            text: 'Hãy quay đầu sang phải',
          );
        }

        Widget _smileCondition(bool isSmile) {
          if (!isSmile && !_didSmile) {
            return DirectionAlert(
              text: 'Hãy mỉm cười!',
            );
          } else {
            _didSmile = true;
            return _headCondition(_headAngle);
          }
        }

        Widget _facesCondition(int facesCount) {
          // EHeadDirection currentHeadDirection = getHeadDirection(_headAngle);
          if (facesCount > 1) {
            _didSmile = _didTurnLeft = _didTurnRight = false;
            return DirectionAlert(
              text: "Vui lòng chỉ đưa 1 gương mặt vào khuôn hình",
            );
          }

          if (facesCount == 0) {
            _didSmile = _didTurnLeft = _didTurnRight = false;
            return DirectionAlert(
              text: "Vui lòng đưa gương mặt vào khuôn hình",
            );
          }
          return _smileCondition(isSmile);
        }

        return Column(
          children: [
            _facesCondition(_facesCount),
          ],
        );
        // return _isSmiled ? Text('Ok') : Text('Hãy nở một nụ cưới');
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  const CirclePainter({this.color = Colors.red});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width / 36
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DirectionAlert extends StatelessWidget {
  const DirectionAlert({@required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
