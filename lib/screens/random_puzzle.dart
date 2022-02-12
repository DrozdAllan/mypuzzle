import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as imglib;
import 'package:image_picker/image_picker.dart';
import 'package:mypuzzle/providers/view_index_provider.dart';
import 'package:mypuzzle/services/image_splitter.dart';

class RandomPuzzle extends ConsumerStatefulWidget {
  const RandomPuzzle({Key? key}) : super(key: key);

  static const routeName = '/random';

  @override
  _RandomPuzzleState createState() => _RandomPuzzleState();
}

class _RandomPuzzleState extends ConsumerState<RandomPuzzle> {
  List<Image> imagePieces = [];
  bool isLoadingImg = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(viewIndexProvider.notifier);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Text("Select the image (and the difficulty) of your choice"),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              height: 200,
              child: const Placeholder()),
          SizedBox(
              width: MediaQuery.of(context).size.width / 6,
              height: 200,
              child: const Placeholder()),
          if (imagePieces.isEmpty)
            SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                height: 200,
                child: const Placeholder()),
          if (imagePieces.isNotEmpty)
            SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                height: 200,
                child: Image(image: imagePieces[0].image)),
        ],
      ),
      ElevatedButton(
          onPressed: () {
            getImage();
            setState(() {});
          },
          child: isLoadingImg
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text('Split the image !')),
      ElevatedButton(
          onPressed: () => notifier.changeIndex(4),
          child: const Text('Start !')),
    ]);
  }

  void getImage() async {
    XFile? xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    var zinzin = await File(xImage!.path).readAsBytes();
    final imglib.Image image = imglib.decodeImage(zinzin)!;
    // 1) Xfile to Image for web ? càd sans dart:io

// 2) Image widget from flutter to Imglib.image du package Image
    setState(() {
      isLoadingImg = true;
    });
    log('converting image to bytes');

    log('image converted to bytes !');

    setState(() {
      imagePieces = splitImage(
          inputImage: image, horizontalPieceCount: 2, verticalPieceCount: 2);
    });
    inspect(imagePieces);
  }
}
