import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingFavorites extends StatelessWidget {
  const ShimmerLoadingFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.white,
      child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 12,
            );
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          const Color.fromARGB(255, 216, 216, 216)),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 216, 216, 216),
                              borderRadius: BorderRadius.circular(18)),
                          width: 150,
                          height: 14,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 216, 216, 216),
                              borderRadius: BorderRadius.circular(18)),
                          width: 100,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: const Color.fromARGB(255, 216, 216, 216),
                  )
                ],
              ),
            );
          }),
    );
  }
}
