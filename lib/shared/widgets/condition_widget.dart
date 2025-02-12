import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:flutter/material.dart';

class ConditionWidget extends StatelessWidget {
  const ConditionWidget({super.key, required this.ad});
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    return ad.condition == 'Б/у'
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 121, 121, 121),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              ad.condition,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 164, 30),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              ad.condition,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          );
  }
}
