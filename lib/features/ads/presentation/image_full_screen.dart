import 'package:flutter/material.dart';

class ImageFullScreen extends StatelessWidget {
  final String imageLink;
  const ImageFullScreen({super.key, required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              child: Image.network(
                width: double.infinity,
                imageLink,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 50,
              left: 10,
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
