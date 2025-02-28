import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/data/sub_category.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/search_result.dart';
import 'package:acousticsapp/features/ads/presentation/sub_categories.dart';
import 'package:acousticsapp/features/ads/widget/category_appbar.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
import 'package:acousticsapp/features/ads/widget/filter_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, required this.category});
  final String category;

  @override
  State<Categories> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<Categories> {
  late List<AdModel> adCategory;
  late FixedExtentScrollController scrollController;

  String criteria = 'Cначала дороже';
  List<Category> results = [];
  List<Subcategory> subcategories = [];
  List<String> brands = [];
  int selectedIndex = 0;
  String selectedRangePrice = '';
  String selectedBrand = '';
  List<String>? items;
  final TextEditingController _searchController = TextEditingController();
  String userType = '';
  var maxPrice = 0;
  var isSearchSelected = false;
  var isCursorShown = false;
  String? selectedSubCategory;
  String? selectedItem;
  double minPriceOf = 0;
  late double maxPriceOf;
  late SfRangeValues _values;

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
    adCategory = ads
        .where((ad) => ad.categorySelection.category == widget.category)
        .toList();
    maxPrice = adCategory
        .map((ad) => int.tryParse(ad.price) ?? 0)
        .fold(0, (max, price) => price > max ? price : max);
    sortAds('price_descending');
    subcategories = categories
        .where((category) => category.category == widget.category)
        .expand((category) => category.subcategories)
        .toList();
    brands = categories
        .where((category) => category.category == widget.category)
        .expand((brand) => brand.brands)
        .toList();
    maxPriceOf = maxPrice > 0 ? maxPrice.toDouble() : 100000;
    scrollController = FixedExtentScrollController(initialItem: selectedIndex);

    _values = SfRangeValues(minPriceOf, maxPriceOf);
  }

  void sortAds(String criterion) {
    List<AdModel> sortedAds = List.from(adCategory);

    switch (criterion) {
      case 'price_ascending':
        sortedAds
            .sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
        break;
      case 'price_descending':
        sortedAds
            .sort((a, b) => int.parse(b.price).compareTo(int.parse(a.price)));
        break;
      case 'date_ascending':
        sortedAds.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'date_descending':
        sortedAds.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    setState(() {
      adCategory = sortedAds;
    });
  }

  void showBrandPicker(Color backgroundColor) {
    scrollController = FixedExtentScrollController(initialItem: selectedIndex);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: Text('Сбросить',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setState(() {
                          selectedBrand = '';
                          selectedIndex = 0;
                        });
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoButton(
                      child: Text('Готово',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (brands.isNotEmpty) {
                          setState(() {
                            selectedBrand = brands[selectedIndex];
                          });
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: scrollController,
                  backgroundColor: backgroundColor,
                  itemExtent: 50,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  children: brands
                      .map((brand) => Center(
                              child: Text(
                            brand,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          )))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showFilterPrice(Color backgroundColor) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      backgroundColor: backgroundColor,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Цена',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${NumberFormat('#,###', 'ru_RU').format(_values.start.toInt())} тг',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(
                          '${NumberFormat('#,###', 'ru_RU').format(_values.end.toInt())} тг',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SfRangeSlider(
                    min: minPriceOf,
                    max: maxPriceOf,
                    values: _values,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.white,
                    onChanged: (value) {
                      setModalState(() {
                        _values = SfRangeValues(value.start, value.end);
                      });
                      selectedRangePrice =
                          '${value.start.toInt()}-${value.end.toInt()}';
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.2,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedRangePrice = '';
                              _values = SfRangeValues(minPriceOf, maxPriceOf);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Сбросить",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.2,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedRangePrice =
                                  '${_values.start.toInt()}-${_values.end.toInt()}';
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Применить",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedSubCategory == null
                                          ? widget.category
                                          : selectedSubCategory!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text('${adCategory.length} товаров')
                                  ],
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
                                    var sortingMethod = await showFilterDialog(
                                        context, sortAds);
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
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
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
                          child: SizedBox(
                            height: size.height * 0.042,
                            child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 10,
                                  );
                                },
                                itemCount: items == null
                                    ? subcategories.length
                                    : items!.length,
                                itemBuilder: (context, index) {
                                  final item = items == null
                                      ? subcategories[index]
                                      : items![index];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (selectedSubCategory != null) {
                                          selectedItem =
                                              (item as String).toString();
                                        }
                                        print(selectedItem);
                                        print(item.toString());
                                        selectedSubCategory = items == null
                                            ? (item as Subcategory).subcategory
                                            : (item as String).toString();
                                        adCategory = items == null
                                            ? ads
                                                .where((ad) =>
                                                    ad.categorySelection
                                                        .subcategory ==
                                                    selectedSubCategory)
                                                .toList()
                                            : ads
                                                .where((ad) =>
                                                    ad.categorySelection.item ==
                                                    selectedItem)
                                                .toList();

                                        items = subcategories
                                            .where((sub) =>
                                                sub.subcategory ==
                                                selectedSubCategory)
                                            .expand((sub) => sub.items)
                                            .toList();

                                        sortAds('price_descending');
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 12),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              221, 15, 41, 156),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text(
                                          items == null
                                              ? (item as Subcategory)
                                                  .subcategory
                                              : (item as String).toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
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
                            child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showFilterPrice(backgroundcolor);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: selectedRangePrice.isEmpty
                                        ? null
                                        : Colors.blueAccent,
                                    border: selectedRangePrice.isEmpty
                                        ? Border.all(color: Colors.grey)
                                        : Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        selectedRangePrice.isNotEmpty
                                            ? '${NumberFormat('#,###', 'ru_RU').format(int.parse(selectedRangePrice.split('-')[0]))} - ${NumberFormat('#,###', 'ru_RU').format(int.parse(selectedRangePrice.split('-')[1]))} тг'
                                            : 'Цена',
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      selectedRangePrice.isNotEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedRangePrice = '';
                                                  _values = SfRangeValues(
                                                      minPriceOf, maxPriceOf);
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )
                                          : Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showBrandPicker(backgroundcolor);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: selectedBrand.isEmpty
                                        ? null
                                        : Colors.blueAccent,
                                    border: selectedBrand.isEmpty
                                        ? Border.all(color: Colors.grey)
                                        : Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(selectedBrand.isNotEmpty
                                          ? selectedBrand
                                          : 'Бренд'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      selectedBrand.isNotEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedBrand = '';
                                                  selectedIndex = 0;
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )
                                          : Icon(
                                              Icons.arrow_drop_down_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text('Город'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
