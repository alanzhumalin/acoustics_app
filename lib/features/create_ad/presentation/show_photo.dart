import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowPhoto extends StatefulWidget {
  const ShowPhoto({
    super.key,
    required this.file,
    required this.index,
  });
  final XFile file;
  final int index;
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
            child: InteractiveViewer(
                clipBehavior: Clip.none,
                child: Image.file(File(widget.file.path))),
          ),
          Positioned(
            left: 10,
            top: 50,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
