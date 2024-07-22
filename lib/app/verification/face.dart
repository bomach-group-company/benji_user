
// import 'dart:io';

// import 'package:face_camera/face_camera.dart';
// import 'package:flutter/material.dart';

// class FaceVerification extends StatefulWidget {
//   const FaceVerification({super.key});

//   @override
//   State<FaceVerification> createState() => _FaceVerificationState();
// }

// class _FaceVerificationState extends State<FaceVerification> {
//   File? _capturedImage;

//   late FaceCameraController controller;

//   @override
//   void initState() {
//     controller = FaceCameraController(
//       autoCapture: true,
//       defaultCameraLens: CameraLens.front,
//       onCapture: (File? image) {
//         setState(() => _capturedImage = image);
//       },
//       onFaceDetected: (Face? face) {
//         //Do something
//       },
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('FaceCamera example app'),
//         ),
//         body: Builder(builder: (context) {
//           if (_capturedImage != null) {
//             return Center(
//               child: Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   Image.file(
//                     _capturedImage!,
//                     width: double.maxFinite,
//                     fit: BoxFit.fitWidth,
//                   ),
//                   ElevatedButton(
//                       onPressed: () async {
//                         await controller.startImageStream();
//                         setState(() => _capturedImage = null);
//                       },
//                       child: const Text(
//                         'Capture Again',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w700),
//                       ))
//                 ],
//               ),
//             );
//           }
//           return SmartFaceCamera(
//               controller: controller,
//               messageBuilder: (context, face) {
//                 if (face == null) {
//                   return _message('Place your face in the camera');
//                 }
//                 if (!face.wellPositioned) {
//                   return _message('Center your face in the square');
//                 }
//                 return const SizedBox.shrink();
//               });
//         }));
//   }

//   Widget _message(String msg) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
//         child: Text(msg,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//                 fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
//       );

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
