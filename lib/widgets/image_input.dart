import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageInput extends StatefulWidget {
  final Function _getImage;
  ImageInput(this._getImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  String? _imagePath;
  Uint8List? result;
  var _storedImage;

  Future<void> getImage() async {
    String? imagePath;

    try {
      imagePath = (await EdgeDetection.detectEdge);
      print("$imagePath");
      File image = File(imagePath!);
      final bytes = image.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      print("FILE SIZE IS: $kb");

      result = (await FlutterImageCompress.compressWithFile(
        imagePath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 10,
      ))!;
      print("FILE 2 SIZE IS: ${result!.lengthInBytes/1024}");
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    if (!mounted) return;
    setState(() {
      _storedImage = File.fromRawPath(result!);
      widget._getImage(_storedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.memory(
            result!,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text(
            'No Image Taken',
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          // ignore: deprecated_member_use
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            textColor: Theme.of(context).primaryColor,
            label: Text('Take Picture'),
            onPressed: getImage,
          ),
        ),
      ],
    );
  }
}