import 'package:flutter/material.dart';

class BrandNameWidget extends StatelessWidget {
  const BrandNameWidget({super.key, required this.brandName});
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 0, 123, 255),
      ),
      child: Text(
        brandName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
