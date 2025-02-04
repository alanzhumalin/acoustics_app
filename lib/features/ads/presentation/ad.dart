import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category_model.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/category_detail.dart';
import 'package:acousticsapp/features/ads/presentation/search.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Ad extends ConsumerWidget {
  const Ad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Acoustics',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Search()),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Категория',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryDetail(category: item.category)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            height: 100,
                            image: AssetImage(
                              item.assets,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        item.category,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ads.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: sizeScreen.width > 366 ? 0.55 : 0.49,
              ),
              itemBuilder: (context, index) {
                final ad = ads[index];

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
                                  image: NetworkImage(ad.imageLink),
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
          ],
        ),
      ),
    );
  }
}
