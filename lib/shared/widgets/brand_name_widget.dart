import 'package:flutter/material.dart';

class BrandNameWidget extends StatelessWidget {
  const BrandNameWidget({super.key, required this.brandName});
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 238, 238, 238),
      ),
      child: Text(
        brandName,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
    );
  }
}
