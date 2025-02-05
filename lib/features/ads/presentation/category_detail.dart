import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CategoryDetail extends ConsumerStatefulWidget {
  const CategoryDetail({super.key, required this.category});
  final String category;

  @override
  ConsumerState<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends ConsumerState<CategoryDetail> {
  late List<AdModel> adCategory;

  @override
  void initState() {
    super.initState();
    adCategory = ads.where((ad) => ad.category == widget.category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    void sortAds(String criterion) {
      switch (criterion) {
        case 'price_ascending':
          setState(() {
            adCategory.sort(
                (a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
          });
          break;
        case 'price_descending':
          setState(() {
            adCategory.sort(
                (a, b) => int.parse(b.price).compareTo(int.parse(a.price)));
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

    void showFilterDialog() {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text('Фильтр'),
            actions: [
              CupertinoActionSheetAction(
                child: Text(
                  'Цена по возрастанию',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  sortAds('price_ascending');
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Цена по убыванию',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  sortAds('price_descending');
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Сначала новые обьявления',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  sortAds('date_descending');
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: Text(
                  'Сначала старые обьявления',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  sortAds('date_ascending');
                  Navigator.pop(context);
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
            icon: const Icon(Icons.filter_list),
            onPressed: showFilterDialog,
          ),
        ],
        forceMaterialTransparency: true,
      ),
      body: adCategory.isEmpty
          ? Center(
              child: Text('Нету таких обьявлении'),
            )
          : GridView.builder(
              itemCount: adCategory.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: size.width > 366 ? 0.55 : 0.49,
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
                  child: Stack(
                    children: [
                      Card(
                        color: Theme.of(context).cardTheme.color,
                        shadowColor: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image(
                                  image: NetworkImage(ad.adImages[0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          ad.title,
                                          style: textTheme.bodyMedium,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          CupertinoIcons.heart,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  ConditionWidget(ad: ad),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${ad.createdAt.day}-${ad.createdAt.month}-${ad.createdAt.year}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${NumberFormat('#,###', 'ru_RU').format(int.parse(ad.price))} тг.',
                                    style: textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ad.city,
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: -4,
                          top: 13,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(40 / 360),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(9)),
                              child: Text(
                                'Магазин',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                            ),
                          )),
                      Positioned(
                          left: 0,
                          top: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                                height: 40,
                                width: 40,
                                image: NetworkImage(
                                    'https://assets.spotlight.fender.com/logos/fender-red-large.jpg')),
                          ))
                    ],
                  ),
                );
              },
            ),
    );
  }
}
