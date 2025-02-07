import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingChats extends StatelessWidget {
  const ShimmerLoadingChats({super.key});

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
                    backgroundColor: const Color.fromARGB(255, 216, 216, 216),
                  ),
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
                          width: 80,
                          height: 14,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 216, 216, 216),
                              borderRadius: BorderRadius.circular(18)),
                          width: 130,
                          height: 12,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 216, 216, 216),
                              borderRadius: BorderRadius.circular(18)),
                          width: 60,
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 216, 216, 216),
                        borderRadius: BorderRadius.circular(18)),
                    width: 80,
                    height: 17,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
