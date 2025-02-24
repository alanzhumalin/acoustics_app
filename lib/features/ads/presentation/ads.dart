import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/presentation/categories.dart';
import 'package:acousticsapp/features/ads/presentation/cubit/search_cubit.dart';
import 'package:acousticsapp/features/ads/widget/ad_appbar.dart';
import 'package:acousticsapp/features/ads/presentation/search_result.dart';
import 'package:acousticsapp/features/ads/widget/ad_grid.dart';
import 'package:acousticsapp/features/ads/widget/category_grid.dart';
import 'package:acousticsapp/shared/bloc/scroll_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/scroll_cubit.dart';

class Ads extends StatefulWidget {
  const Ads({super.key});

  @override
  State<Ads> createState() => _AdState();
}

class _AdState extends State<Ads> {
  double value = 0.2;
  var isSearchSelected = false;
  var isCursorShown = false;
  TextEditingController searchController = TextEditingController();
  List<Category> results = [];
  String userType = '';

  @override
  void initState() {
    super.initState();
    context.read<SearchCubit>().loadRecentSearches();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String query) {
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

  double _calculateHeight(double screenHeight) {
    if (screenHeight <= 603) return screenHeight * 0.45;
    if (screenHeight <= 649) return screenHeight * 0.42;
    if (screenHeight <= 706) return screenHeight * 0.39;
    if (screenHeight <= 749) return screenHeight * 0.36;
    if (screenHeight <= 794) return screenHeight * 0.34;
    if (screenHeight <= 877) return screenHeight * 0.31;
    return screenHeight * 0.29;
  }

  double calculateWidth(double screenWidth) {
    if (screenWidth <= 364) return 0.45;
    if (screenWidth <= 384) return 0.48;
    if (screenWidth <= 406) return 0.51;
    if (screenWidth <= 414) return 0.54;
    if (screenWidth <= 430) return 0.57;
    return 0.60;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;
    final scrollLinearCubit = context.read<ScrollLinearCubit>();
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final scrollController = context.read<ScrollHomeCubit>().state;

    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AdAppbar(
        searchController: searchController,
        isSearchSelected: isSearchSelected,
        isCursorShown: isCursorShown,
        onBackPressed: () {
          setState(() {
            isSearchSelected = false;
            isCursorShown = false;
            searchController.clear();

            search('');

            WidgetsBinding.instance.addPostFrameCallback((_) {
              FocusManager.instance.primaryFocus?.unfocus();
            });
          });
        },
        onSearchChanged: search,
        onSearchTap: () {
          setState(() {
            isSearchSelected = true;
            isCursorShown = true;
          });
        },
        containerColor: containerColor,
      ),
      body: CustomScrollView(controller: scrollController, slivers: [
        isSearchSelected
            ? BlocBuilder<SearchCubit, List<String>>(
                builder: (context, searchHistory) {
                  return userType.isEmpty
                      ? searchHistory.isEmpty
                          ? const SliverFillRemaining(
                              child: Center(
                                child: Text(
                                  'Начните вводить для поиска...',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Последние запросы',
                                          style:
                                              textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<SearchCubit>()
                                                .clearSearches();
                                          },
                                          child: Text(
                                            'Очистить',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: searchHistory.length,
                                        itemBuilder: (context, index) {
                                          final item = searchHistory[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Categories(
                                                              category: item)));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: containerColor,
                                                borderRadius: _getBorderRadius(
                                                    index, searchHistory),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              width: double.infinity,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            )
                      : results.isEmpty
                          ? const SliverFillRemaining(
                              child: Center(
                                child: Text(
                                  'Ничего не найдено',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          : SearchResult(
                              results: results, containerColor: containerColor);
                },
              )
            : SliverMainAxisGroup(slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 5,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: containerColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Категории',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CategoryGrid(
                            height: _calculateHeight(sizeScreen.height),
                            scrollController:
                                scrollLinearCubit.scrollLinearController,
                            categories: categories,
                            textTheme: textTheme)
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeScreen.width * 0.45),
                    child: BlocBuilder<ScrollLinearCubit, double>(
                        builder: (context, scrollProgress) {
                      return LinearProgressIndicator(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        value: scrollProgress,
                        color: Colors.amber,
                      );
                    }),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 5)),
                SliverToBoxAdapter(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Рекомендация',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: const SizedBox(height: 9)),
                SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    sliver: AdGrid(
                        ads: ads,
                        calculateWidth: calculateWidth,
                        screenSize: sizeScreen)),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ])
      ]),
    );
  }

  BorderRadius? _getBorderRadius(int index, List<String> search) {
    if (index == 0) {
      return index + 1 == search.length
          ? BorderRadius.circular(8)
          : const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            );
    } else if (index + 1 == search.length) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return null;
  }
}
