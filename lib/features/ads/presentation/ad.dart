import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/category_detail.dart';
import 'package:acousticsapp/features/ads/presentation/search.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
import 'package:acousticsapp/features/ads/widget/shimmer_loading_category.dart';
import 'package:acousticsapp/shared/provider/page_scroll_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ad extends ConsumerStatefulWidget {
  const Ad({super.key});

  @override
  ConsumerState<Ad> createState() => _AdState();
}

class _AdState extends ConsumerState<Ad> {
  final ScrollController _scrollController = ScrollController();
  double value = 0.2;
  var isSearchSelected = false;
  var isCursorShown = false;
  TextEditingController searchController = TextEditingController();
  List<Category> results = [];
  String userType = '';

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

  double calculateWidth(double screenWidth) {
    if (screenWidth <= 341) return 0.47;

    if (screenWidth <= 362) return 0.49;
    if (screenWidth <= 397) return 0.52;
    return 0.57;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        double progress = _scrollController.offset /
            _scrollController.position.maxScrollExtent;
        value = 0.2 + (progress * 0.8);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;
    final searchColor = Theme.of(context).colorScheme.secondaryContainer;
    final containerColor = Theme.of(context).colorScheme.secondaryContainer;
    final scrollController = ref.watch(pageScrollControllerProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        titleSpacing: 10,
        centerTitle: false,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
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
                    prefixIcon: isSearchSelected
                        ? IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                isSearchSelected = false;
                                isCursorShown = false;

                                searchController.clear();
                                search('');
                                FocusScope.of(context).unfocus();
                              });
                            },
                            icon: Icon(Icons.arrow_back_ios))
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
            if (!isSearchSelected)
              Icon(
                Icons.notifications,
                color: Colors.orange,
              )
          ],
        ),
      ),
      body: isSearchSelected
          ? userType.isEmpty
              ? SizedBox(
                  height: sizeScreen.height,
                  child: const Center(
                    child: Text(
                      'Начните вводить для поиска...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : results.isEmpty
                  ? const Center(
                      child: Text(
                        'Ничего не найдено',
                        style: TextStyle(color: Colors.grey),
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
                                      ? index + 1 == results.length
                                          ? BorderRadius.all(Radius.circular(8))
                                          : BorderRadius.only(
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
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
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
                    height: 20,
                  ),
                  SizedBox(
                    height: _calculateHeight(sizeScreen.height),
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        crossAxisSpacing: 18,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryDetail(category: item.category),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/category_photos/guitar_accecsories.webp'),
                                  radius: 40,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
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
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeScreen.width * 0.45),
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(8),
                      value: value,
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Рекомендация',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ),
                  SizedBox(height: 9),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: ads.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        childAspectRatio: calculateWidth(sizeScreen.width)),
                    itemBuilder: (context, index) {
                      final ad = ads[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdDetail(ad: ad),
                            ),
                          );
                        },
                        child: CustomAdWidget(ad: ad),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
