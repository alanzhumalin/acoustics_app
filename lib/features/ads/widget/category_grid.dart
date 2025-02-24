import 'package:acousticsapp/features/ads/presentation/categories.dart';
import 'package:flutter/material.dart';
import '../data/category.dart';

class CategoryGrid extends StatelessWidget {
  final double height;
  final ScrollController scrollController;
  final List<Category> categories;
  final TextTheme textTheme;

  const CategoryGrid({
    super.key,
    required this.height,
    required this.scrollController,
    required this.categories,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GridView.builder(
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 18,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Categories(category: item.category),
                ),
              );
            },
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/category_photos/guitar_accecsories.webp'),
                  radius: 40,
                ),
                const SizedBox(height: 3),
                Text(
                  item.category,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: textTheme.bodyLarge!.color,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
