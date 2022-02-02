// https://pub.dev/packages/image

// https://github.com/brendan-duncan/image/wiki/Examples 


// SPLIT IMAGES INTO PIECES
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as imglib;

// List<Image> splitImage({Image inputImage, int horizontalPieceCount, int verticalPieceCount}) {
//   imglib.Image image = inputImage as imglib.Image;

//   final int xLength = (image.width / horizontalPieceCount).round();
//   final int yLength = (image.height / verticalPieceCount).round();
//   List<imglib.Image> pieceList = List<imglib.Image>();

//   for (int y = 0; y < verticalPieceCount; y++)
//     for (int x = 0; x < horizontalPieceCount; x++) {
//       pieceList.add(
//         imglib.copyCrop(image, x, y, x * xLength, y * yLength),
//       );
//     }

//   //Convert image from image package to Image Widget to display
//   List<Image> outputImageList = List<Image>();
//   for (imglib.Image img in pieceList) {
//     outputImageList.add(Image.memory(imglib.encodeJpg(img)));
//   }

//   return outputImageList;
// }


// maybe this function in the package relies on Image clone() :
// https://api.flutter.dev/flutter/dart-ui/Image/clone.html