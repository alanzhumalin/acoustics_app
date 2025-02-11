import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAdWidget extends StatelessWidget {
  const CustomAdWidget({super.key, required this.ad});
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
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
            padding: const EdgeInsets.only(
              left: 10,
              right: 0,
              top: 5,
              bottom: 5,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
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
                    Row(children: [
                      ConditionWidget(ad: ad),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(9)),
                        child: Text(
                          'Магазин',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ]),
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
                Positioned(
                    right: 5,
                    bottom: -25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          Image(height: 35, image: NetworkImage(ad.brandImage)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
