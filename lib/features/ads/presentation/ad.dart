import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/features/ads/presentation/category_detail.dart';
import 'package:acousticsapp/features/ads/presentation/search.dart';
import 'package:acousticsapp/features/ads/widget/custom_ad_widget.dart';
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sizeScreen = MediaQuery.of(context).size;
    final searchColor = Theme.of(context).colorScheme.secondaryContainer;
    final _pageScrollControllerProvider =
        ref.watch(pageScrollControllerProvider);
    return Scaffold(
      body: CustomScrollView(
        controller: _pageScrollControllerProvider,
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: 43,
            titleSpacing: 10,
            centerTitle: false,
            forceMaterialTransparency: true,
            title: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Search()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: searchColor,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Поиск',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 132, 132, 132))),
                          Icon(Icons.search, size: 21, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.orange,
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Категории',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: sizeScreen.height * 0.29,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: sizeScreen.width > 366 ? 1.1 : 1.2,
                    mainAxisSpacing: 13),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: categories.length,
                physics: const ClampingScrollPhysics(),
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 6,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.45),
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8),
                value: value,
                color: Colors.amber,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Рекомендация',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 9),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 7,
              crossAxisSpacing: 7,
              childAspectRatio: sizeScreen.width > 366 ? 0.57 : 0.49,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
              childCount: ads.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}
