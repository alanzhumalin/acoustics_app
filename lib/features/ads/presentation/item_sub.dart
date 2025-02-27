import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/data/sub_category.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/search_result.dart';
import 'package:acousticsapp/features/ads/widget/category_appbar.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemSub extends StatefulWidget {
  const ItemSub({super.key, required this.item});
  final String item;
  @override
  State<ItemSub> createState() => _ItemSubState();
}

class _ItemSubState extends State<ItemSub> {
  late List<AdModel> adCategory;
  String criteria = 'Cначала дороже';
  List<Category> results = [];
  final TextEditingController _searchController = TextEditingController();
  String userType = '';
  var isSearchSelected = false;
  var isCursorShown = false;
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

  double calculateWidth(double screenWidth) {
    if (screenWidth <= 364) return 0.45;

    if (screenWidth <= 384) return 0.48;

    if (screenWidth <= 406) return 0.51;

    if (screenWidth <= 414) return 0.54;
    if (screenWidth <= 430) return 0.57;
    return 0.60;
  }

  @override
  void initState() {
    super.initState();
    adCategory =
        ads.where((ad) => ad.categorySelection.item == widget.item).toList();
    sortAds('price_descending');

    // .firstWhere((category) => category.category == widget.category)
    // .subcategories;
  }

  void sortAds(String criterion) {
    switch (criterion) {
      case 'price_ascending':
        setState(() {
          adCategory
              .sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
        });
        break;
      case 'price_descending':
        setState(() {
          adCategory
              .sort((a, b) => int.parse(b.price).compareTo(int.parse(a.price)));
        });
        break;
      case 'date_ascending':
        setState(() {
          adCategory.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        });
        break;
      case 'date_descending':
        setState(() {
          adCategory.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        });
        break;
      default:
        break;
    }
  }

  Future<String?> showFilterDialog() async {
    return await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('Фильтр'),
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Сначала дешевле',
                  style: TextStyle(color: Colors.blue)),
              onPressed: () {
                sortAds('price_ascending');
                Navigator.of(context).pop('Сначала дешевле');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Сначала дороже',
                  style: TextStyle(color: Colors.blue)),
              onPressed: () {
                sortAds('price_descending');
                Navigator.of(context).pop('Сначала дороже');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Сначала новые обьявления',
                  style: TextStyle(color: Colors.blue)),
              onPressed: () {
                sortAds('date_descending');
                Navigator.of(context).pop('Сначала новые обьявления');
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Сначала старые обьявления',
                  style: TextStyle(color: Colors.blue)),
              onPressed: () {
                sortAds('date_ascending');
                Navigator.of(context).pop('Сначала старые обьявления');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Отмена', style: TextStyle(color: Colors.red)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundcolor,
        appBar: CategoryAppBar(
          searchController: _searchController,
          isSearchSelected: isSearchSelected,
          isCursorShown: isCursorShown,
          onBackPressed: () {
            Navigator.pop(context);
          },
          onClearPressed: () {
            setState(() {
              isSearchSelected = false;
              isCursorShown = false;
              _searchController.clear();
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
        body: CustomScrollView(slivers: [
          isSearchSelected
              ? userType.isEmpty
                  ? SliverFillRemaining(
                      child: const Center(
                        child: Text(
                          'Начните вводить для поиска...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : results.isEmpty
                      ? SliverFillRemaining(
                          child: const Center(
                            child: Text(
                              'Ничего не найдено',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : SearchResult(
                          results: results, containerColor: containerColor)
              : adCategory.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: const Text('Нету таких обьявлении'),
                      ),
                    )
                  : SliverMainAxisGroup(
                      slivers: [
                        // SliverToBoxAdapter(
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 20, vertical: 5),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //           color: containerColor,
                        //           borderRadius: BorderRadius.circular(15)),
                        //       width: double.infinity,
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           TextButton.icon(
                        //               style: ButtonStyle(
                        //                 splashFactory: NoSplash.splashFactory,
                        //               ),
                        //               icon: Icon(
                        //                   CupertinoIcons.slider_horizontal_3,
                        //                   color: textTheme.bodyLarge!.color),
                        //               onPressed: () {},
                        //               label: Text(
                        //                 'Фильтр',
                        //                 style: TextStyle(
                        //                     fontWeight: FontWeight.w400,
                        //                     color: textTheme.bodySmall!.color),
                        //               )),
                        SliverToBoxAdapter(
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.item,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text('${adCategory.length} товаров')
                                    ],
                                  ),
                                ),
                                IconButton(
                                  style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  icon: Icon(
                                    Icons.filter_list,
                                    color: textTheme.bodyLarge!.color,
                                  ),
                                  onPressed: () async {
                                    var sortingMethod =
                                        await showFilterDialog();
                                    if (sortingMethod != null) {
                                      setState(() {
                                        criteria = sortingMethod;
                                      });
                                    }
                                    return;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Divider(
                            height: 1,
                          ),
                        ),

                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),

                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text('Цена'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text('Бренд'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text('Местоположение'),
                              )
                            ],
                          ),
                        )),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),

                        const SliverToBoxAdapter(
                          child: Divider(
                            height: 1,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),

                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          sliver: SliverGrid.builder(
                            itemCount: adCategory.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 7,
                              childAspectRatio: calculateWidth(size.width),
                            ),
                            itemBuilder: (context, index) {
                              final ad = adCategory[index];

                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdDetail(ad: ad)));
                                  },
                                  child: CustomAdWidget(ad: ad));
                            },
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                      ],
                    ),
        ]),
      ),
    );
  }
}
