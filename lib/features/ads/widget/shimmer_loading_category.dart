import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingCategory extends StatelessWidget {
  const ShimmerLoadingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: SizedBox(
        height: sizeScreen.height * 0.29,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: sizeScreen.width > 366 ? 1.1 : 1.2,
              mainAxisSpacing: 13),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          itemCount: 8,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 216, 216, 216),
                  radius: 40,
                ),
                SizedBox(
                  height: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 10,
                    width: 65,
                    color: const Color.fromARGB(255, 216, 216, 216),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
