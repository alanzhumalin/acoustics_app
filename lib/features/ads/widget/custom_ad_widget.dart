import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAdWidget extends StatefulWidget {
  const CustomAdWidget({super.key, required this.ad});
  final AdModel ad;

  @override
  State<CustomAdWidget> createState() => _CustomAdWidgetState();
}

class _CustomAdWidgetState extends State<CustomAdWidget> {
  bool isSelected = false;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final containerColor = Theme.of(context).colorScheme.primaryContainer;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemCount: widget.ad.adImages.length,
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        fadeInCurve: Curves.linear,
                        fadeOutCurve: Curves.linear,
                        imageUrl: widget.ad.adImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                  right: 3.5,
                  top: 3.5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        fadeInCurve: Curves.linear,
                        fadeOutCurve: Curves.linear,
                        imageUrl: widget.ad.categorySelection.brandImage,
                        height: 30,
                      ))),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: containerColor),
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 5, top: 9, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.ad.title,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            IconButton(
                              iconSize: 25,
                              isSelected: isSelected,
                              padding: EdgeInsets.zero,
                              constraints:
                                  BoxConstraints(minHeight: 10, minWidth: 40),
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              selectedIcon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                              icon: const Icon(
                                Icons.favorite_outline,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ConditionWidget(ad: widget.ad),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${NumberFormat('#,###', 'ru_RU').format(int.parse(widget.ad.price))} тг.',
                          style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                        const SizedBox(height: 5),
                        Text(
                          widget.ad.city,
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${widget.ad.createdAt.day}-${widget.ad.createdAt.month}-${widget.ad.createdAt.year}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.ad.adImages.length != 1)
                  Positioned(
                      top: 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.ad.adImages.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              width: currentIndex == index ? 7 : 5,
                              height: currentIndex == index ? 7 : 5,
                              decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
