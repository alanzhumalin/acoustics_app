import 'package:flutter/material.dart';
import '../data/ad_model.dart';
import '../presentation/ad_detail.dart';
import 'custom_ad_widget.dart';

class AdGrid extends StatelessWidget {
  final List<AdModel> ads;
  final double Function(double) calculateWidth;
  final Size screenSize;

  const AdGrid({
    super.key,
    required this.ads,
    required this.calculateWidth,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: ads.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 7,
        childAspectRatio: calculateWidth(screenSize.width),
      ),
      itemBuilder: (context, index) {
        final ad = ads[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdDetail(ad: ad),
              ),
            );
          },
          child: CustomAdWidget(ad: ad),
        );
      },
    );
  }
}
