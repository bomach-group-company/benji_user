// import 'dart:io';

// import 'package:face_camera/face_camera.dart';
// import 'package:flutter/material.dart';

// class FaceVerify extends StatefulWidget {
//   const FaceVerify({super.key});

//   @override
//   State<FaceVerify> createState() => _FaceVerifyState();
// }

// class _FaceVerifyState extends State<FaceVerify> {
//   late FaceCameraController controller;

//   @override
//   void initState() {
//     controller = FaceCameraController(
//       autoCapture: true,
//       defaultCameraLens: CameraLens.front,
//       onCapture: (File? image) {
//         print('in here oo');
//       },
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SmartFaceCamera(
//       controller: controller,
//       message: 'Center your face in the square',
//     ));
//   }
// }
