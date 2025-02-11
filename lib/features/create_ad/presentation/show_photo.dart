import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowPhoto extends StatefulWidget {
  const ShowPhoto(
      {super.key,
      required this.file,
      required this.index,
      required this.removeFile});
  final XFile file;
  final int index;
  final Function removeFile;
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
                  icon: Icon(Icons.arrow_back_ios))),
          Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: InkWell(
                onTap: () {
                  widget.removeFile(widget.index);
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 40,
                ),
              ))
        ],
      ),
    );
  }
}
