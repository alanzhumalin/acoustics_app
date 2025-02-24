import 'package:acousticsapp/features/ads/presentation/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/category.dart';
import 'categories.dart';

class SearchResult extends StatelessWidget {
  final List<Category> results;
  final Color containerColor;

  const SearchResult({
    super.key,
    required this.results,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Найдено ${results.length} результатов:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final category = results[index];
                return GestureDetector(
                  onTap: () {
                    context.read<SearchCubit>().saveQuery(category.category);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Categories(
                          category: category.category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: _getBorderRadius(index),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    width: double.infinity,
                    child: Text(
                      category.category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  BorderRadius? _getBorderRadius(int index) {
    if (index == 0) {
      return index + 1 == results.length
          ? BorderRadius.circular(8)
          : const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            );
    } else if (index + 1 == results.length) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return null;
  }
}
