import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
import 'package:acousticsapp/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryDetail extends ConsumerStatefulWidget {
  const CategoryDetail({super.key, required this.category});
  final String category;

  @override
  ConsumerState<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends ConsumerState<CategoryDetail> {
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

  double _calculateHeight(double screenHeight) {
    if (screenHeight <= 706) return screenHeight * 0.39;
    if (screenHeight <= 749) return screenHeight * 0.36;
    if (screenHeight <= 794) return screenHeight * 0.34;
    if (screenHeight <= 877) return screenHeight * 0.31;
    return screenHeight * 0.29;
  }

  double _calculateWidth(double screenWidth) {
    if (screenWidth <= 341) return 0.47;

    if (screenWidth <= 362) return 0.49;
    if (screenWidth <= 397) return 0.52;
    return 0.57;
  }

  @override
  void initState() {
    super.initState();
    adCategory = ads
        .where((ad) => ad.categorySelection.category == widget.category)
        .toList();
    sortAds('price_descending');
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
      builder: (BuildContext context) {
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
    final color = Theme.of(context).colorScheme.onSecondaryContainer;
    final searchColor = Theme.of(context).colorScheme.secondaryContainer;
    final containerColor = Theme.of(context).colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          titleSpacing: 10,
          forceMaterialTransparency: true,
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: search,
                  onTap: () {
                    setState(() {
                      isSearchSelected = true;
                      isCursorShown = true;
                    });
                  },
                  showCursor: isCursorShown,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      suffixIcon: isSearchSelected
                          ? IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  isSearchSelected = false;
                                  isCursorShown = false;

                                  _searchController.clear();
                                  search('');
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              icon: Icon(Icons.close_sharp))
                          : null,
                      filled: true,
                      fillColor: searchColor,
                      constraints: BoxConstraints(maxHeight: 39),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      hintText: 'Поиск',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 132, 132, 132)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                CupertinoIcons.search,
                color: Colors.blue,
                size: 20,
              ),
            ],
          ),
        ),
        body: isSearchSelected
            ? userType.isEmpty
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
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final category = results[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryDetail(
                                          category: category.category))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: index == 0
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))
                                        : index + 1 == results.length
                                            ? BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight: Radius.circular(8))
                                            : null),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.category,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Divider(
                                      height: 5,
                                      thickness: 1,
                                      color: const Color.fromARGB(
                                          255, 131, 131, 131),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
            : adCategory.isEmpty
                ? Center(
                    child: Text('Нету таких обьявлении'),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(15)),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                    style: ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    icon: Icon(
                                        CupertinoIcons.slider_horizontal_3,
                                        color: textTheme.bodyLarge!.color),
                                    onPressed: () {},
                                    label: Text(
                                      'Фильтр',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: textTheme.bodySmall!.color),
                                    )),
                                TextButton.icon(
                                    style: ButtonStyle(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    icon: Icon(
                                      CupertinoIcons.sort_down,
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
                                    label: Text(
                                      criteria,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: textTheme.bodySmall!.color),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: adCategory.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 7,
                            crossAxisSpacing: 7,
                            childAspectRatio: _calculateWidth(size.width),
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
                      ],
                    ),
                  ),
      ),
    );
  }
}
