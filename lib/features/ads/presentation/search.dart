import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/category_detail.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Category> results = [];
  String userType = '';

  void _search(String query) {
    setState(() {
      userType = query;
      results = query.isEmpty
          ? []
          : categories
              .where((category) =>
                  category.category.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final containerColor = Theme.of(context).colorScheme.secondaryContainer;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: TextField(
          autocorrect: false,
          onChanged: _search,
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Поиск...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: userType.isEmpty
          ? const Center(
              child: Text(
                'Начните вводить для поиска...',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : results.isEmpty
              ? const Center(
                  child: Text(
                    'Ничего не найдено',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final category = results[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryDetail(
                                      category: category.category))),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category.category,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                if (index + 1 != results.length)
                                  Divider(
                                    height: 25,
                                    color: const Color.fromARGB(
                                        255, 131, 131, 131),
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
