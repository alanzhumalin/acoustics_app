import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category_model.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/category_detail.dart';
import 'package:acousticsapp/features/ads/presentation/search.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
import 'package:acousticsapp/features/ads/widget/shimmer_loading_ads.dart';
import 'package:acousticsapp/features/ads/widget/shimmer_loading_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ad extends ConsumerWidget {
  const Ad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 43,
          titleSpacing: 10,
          centerTitle: false,
          forceMaterialTransparency: true,
          title: Row(
            children: [
              Text(
                'Acoustics',
                style: textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Search()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    padding:
                        EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 237, 237, 237),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Поиск...',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Категории',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) => const SizedBox(width: 17),
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
                            height: 102,
                            image: AssetImage(
                              item.assets,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Все обьявления',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ads.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: sizeScreen.width > 366 ? 0.59 : 0.49,
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
                    child: CustomAdWidget(ad: ad));
              },
            ),
          ],
        ),
      ),
    );
  }
}
