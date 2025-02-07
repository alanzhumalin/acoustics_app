import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingCategory extends StatelessWidget {
  const ShimmerLoadingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: SizedBox(
        height: 150,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: const Color.fromARGB(255, 216, 216, 216),
                    )),
                SizedBox(
                  height: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 15,
                    width: 80,
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
