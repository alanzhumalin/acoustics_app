import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowPhoto extends StatefulWidget {
  const ShowPhoto({super.key, required this.file});
  final XFile file;
  @override
  State<ShowPhoto> createState() => _ShowPhotoState();
}

class _ShowPhotoState extends State<ShowPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(child: Image.file(File(widget.file.path))),
          ),
          Positioned(
              left: 10,
              top: 50,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)))
        ],
      ),
    );
  }
}
