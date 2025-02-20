import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFullScreen extends StatefulWidget {
  final List<String> imagesLink;
  final int indexInitial;
  const ImageFullScreen(
      {super.key, required this.imagesLink, required this.indexInitial});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  late PageController pageController;
  late int currentIndex;
  bool isScaled = false;
  Offset _startVerticalDrag = Offset.zero;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.indexInitial;
    pageController = PageController(initialPage: widget.indexInitial);
    pageController.addListener(() {
      setState(() {
        currentIndex = pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onVerticalDragStart: (details) {
          _startVerticalDrag = details.globalPosition;
        },
        onVerticalDragUpdate: (details) {
          double delta = details.globalPosition.dy - _startVerticalDrag.dy;
          if (delta > 100) {
            Navigator.of(context).pop(currentIndex);
          }
        },
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                onInteractionStart: (details) {
                  setState(() {
                    isScaled = true;
                  });
                },
                onInteractionEnd: (details) {
                  if (details.pointerCount == 1) {
                    setState(() {
                      isScaled = false;
                    });
                  }
                },
                clipBehavior: Clip.none,
                child: PageView.builder(
                  itemCount: widget.imagesLink.length,
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                        imageUrl: widget.imagesLink[index]);
                  },
                ),
              ),
            ),
            if (widget.imagesLink.length != 1)
              if (!isScaled)
                Positioned(
                  bottom: 150,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.imagesLink.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            width: currentIndex == index ? 7 : 5,
                            height: currentIndex == index ? 7 : 5,
                            decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Colors.blue
                                  : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(14)),
                child: Center(
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(currentIndex);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
