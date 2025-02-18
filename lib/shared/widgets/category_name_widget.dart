import 'package:flutter/material.dart';

class CategoryNameWidget extends StatelessWidget {
  const CategoryNameWidget({super.key, required this.brandName});
  final String brandName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 255, 115, 0),
      ),
      child: Text(
        brandName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
