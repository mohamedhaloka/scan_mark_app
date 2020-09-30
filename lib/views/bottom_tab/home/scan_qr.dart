// import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// List<CameraDescription> cameras;
//
// class CameraApp extends StatefulWidget {
//   static String id = "Camera App";
//   @override
//   _CameraAppState createState() => new _CameraAppState();
// }
//
// class _CameraAppState extends State<CameraApp> {
//
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!controller.value.isInitialized) {
//       return new Container();
//     }
//     return new AspectRatio(
//         aspectRatio: controller.value.aspectRatio,
//         child: new QRReaderPreview(controller));
//   }
// }
