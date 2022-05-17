import 'dart:io';

import 'package:flutter/material.dart';

class ImageWithBackground extends StatefulWidget {
  final String? asset;
  final File? file;

  const ImageWithBackground({Key? key, this.asset, this.file})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageWithBackgroundState();
  }
}

class ImageWithBackgroundState extends State<ImageWithBackground> {
  @override
  Widget build(BuildContext context) {
    ImageProvider? img;

    if (widget.asset != null) {
      img = AssetImage(widget.asset!);
    } else if (widget.file != null) {
      img = FileImage(widget.file!);
    }

    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 32, 32),
        image: DecorationImage(
          image: img!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
