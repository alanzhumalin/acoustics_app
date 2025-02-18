import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
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

  Future<String>? showFilterDialog() async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Фильтр'),
          actions: [
            CupertinoActionSheetAction(
              child: Text(
                'Сначала дешевле',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                sortAds('price_ascending');
                Navigator.of(context).pop('Сначала дешевле');
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Сначала дороже',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                sortAds('price_descending');
                Navigator.of(context).pop('Сначала дороже');
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Сначала новые обьявления',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                sortAds('date_descending');
                Navigator.of(context).pop('Сначала новые обьявления');
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Сначала старые обьявления',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                sortAds('date_ascending');
                Navigator.of(context).pop('Сначала старые обьявления');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Отмена',
              style: TextStyle(color: Colors.red),
            ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.search,
                color: Colors.blue,
              ))
        ],
        forceMaterialTransparency: true,
      ),
      body: adCategory.isEmpty
          ? Center(
              child: Text('Нету таких обьявлении'),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                              icon: Icon(CupertinoIcons.slider_horizontal_3,
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
                                var sortingMethod = await showFilterDialog();
                                if (sortingMethod != null) {
                                  setState(() {
                                    criteria = sortingMethod;
                                  });
                                }
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      childAspectRatio: size.width > 366 ? 0.57 : 0.49,
                    ),
                    itemBuilder: (context, index) {
                      final ad = adCategory[index];

                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdDetail(ad: ad)));
                          },
                          child: CustomAdWidget(ad: ad));
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
