import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;

List<Image> splitImage(
    {required imglib.Image inputImage,
    required int horizontalPieceCount,
    required int verticalPieceCount}) {
//   imglib.Image image = inputImage as imglib.Image;
//   log('decoding bytes to imglibg Image...');
//   imglib.Image image = imglib.Image.fromBytes(1, 1, inputImage);
//   imglib.Image image = inputImage as imglib.Image;
//   log('bytes decoded to imglibg Image !');

  final int xLength = (inputImage.width / horizontalPieceCount).round();
  final int yLength = (inputImage.height / verticalPieceCount).round();
  List<imglib.Image> pieceList = [];

  log('splitting image into pieces...');
  for (int y = 0; y < verticalPieceCount; y++) {
    for (int x = 0; x < horizontalPieceCount; x++) {
      pieceList.add(
        imglib.copyCrop(inputImage, x, y, x * xLength, y * yLength),
      );
    }
  }
  log('splitting done !');

  log('converting imgLibg image to a an image list widget...');
  //Convert image from image package to Image Widget to display
  List<Image> outputImageList = [];
  for (imglib.Image img in pieceList) {
    // outputImageList.add(Image.memory(imglib.encodeJpg(img)));
    outputImageList.add(Image.memory(imglib.encodeJpg(img) as Uint8List));
  }
  log('finished ! returning...');

  return outputImageList;
}


// https://pub.dev/packages/image

// https://github.com/brendan-duncan/image/wiki/Examples 


// SPLIT IMAGES INTO PIECES
// maybe this function in the package relies on Image clone() :
// https://api.flutter.dev/flutter/dart-ui/Image/clone.html