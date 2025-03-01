import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/presentation/categories.dart';
import 'package:acousticsapp/features/ads/presentation/cubit/recent_search_cubit.dart';
import 'package:acousticsapp/features/ads/presentation/cubit/search_cubit.dart';
import 'package:acousticsapp/features/ads/widget/ad_appbar.dart';
import 'package:acousticsapp/features/ads/presentation/search_result.dart';
import 'package:acousticsapp/features/ads/widget/ad_grid.dart';
import 'package:acousticsapp/features/ads/widget/category_grid.dart';
import 'package:acousticsapp/features/ads/widget/sponsors.dart';
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
  String userType = '';
  late SearchCubit searchCubit;
  @override
  void initState() {
    super.initState();
    context.read<RecentSearchCubit>().loadRecentSearches();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    searchCubit = context.read<SearchCubit>();
  }

  @override
  void dispose() {
    searchCubit.clearSearch();
    super.dispose();
  }

  void search(String query) {
    context.read<SearchCubit>().search(query);
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
    if (screenWidth <= 331) return 0.43;

    if (screenWidth <= 358) return 0.46;

    if (screenWidth <= 384) return 0.50;
    if (screenWidth <= 406) return 0.54;
    if (screenWidth <= 423) return 0.57;
    if (screenWidth <= 444) return 0.60;
    if (screenWidth <= 459) return 0.63;
    return 0.65;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;
    final scrollLinearCubit = context.read<ScrollLinearCubit>();
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    final scrollController = context.read<ScrollHomeCubit>().state;

    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            final searchCubit = context.read<SearchCubit>();

            return AdAppbar(
              searchController: searchCubit.searchController,
              isSearchSelected: state.isSearchSelected,
              isCursorShown: state.isCursorShown,
              onBackPressed: () => searchCubit.clearSearch(),
              onSearchChanged: (query) => searchCubit.search(query),
              onSearchTap: () => searchCubit.toggleSearch(true),
              containerColor: Theme.of(context).colorScheme.primaryContainer,
            );
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
        return CustomScrollView(controller: scrollController, slivers: [
          state.isSearchSelected
              ? BlocBuilder<RecentSearchCubit, List<String>>(
                  builder: (context, searchHistory) {
                    return state.query.isEmpty
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  .read<RecentSearchCubit>()
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
                                          physics:
                                              const NeverScrollableScrollPhysics(),
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
                                                                category:
                                                                    item)));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: containerColor,
                                                  borderRadius:
                                                      _getBorderRadius(
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
                        : state.results.isEmpty
                            ? const SliverFillRemaining(
                                child: Center(
                                  child: Text(
                                    'Ничего не найдено',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            : SearchResult(
                                results: state.results,
                                containerColor: containerColor);
                  },
                )
              : SliverMainAxisGroup(slivers: [
                  SliverToBoxAdapter(
                    child: Sponsors(),
                  ),
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
                            height: 10,
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
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
        ]);
      }),
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
