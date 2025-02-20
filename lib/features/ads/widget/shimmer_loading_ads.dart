import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingAds extends StatelessWidget {
  const ShimmerLoadingAds({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: GridView.builder(
          itemCount: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: sizeScreen.width > 366 ? 0.55 : 0.49,
              crossAxisSpacing: 6),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      color: const Color.fromARGB(255, 216, 216, 216),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                          ]),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 140,
                        height: 20,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        width: 70,
                        height: 20,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 216, 216, 216),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
