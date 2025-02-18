import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomAdWidget extends StatelessWidget {
  const CustomAdWidget({super.key, required this.ad});
  final AdModel ad;
  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.2, color: borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                height: 190,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Center(
                      child: CachedNetworkImage(
                    imageUrl: ad.adImages[0],
                    fit: BoxFit.contain,
                  )),
                ),
              ),
              Positioned(
                  right: 3.5,
                  top: 3.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                        height: 30,
                        image: NetworkImage(ad.categorySelection.brandImage)),
                  )),
            ],
          ),
          Expanded(
            child: Card(
              shadowColor: Colors.transparent,
              margin: EdgeInsets.all(0),
              color: Theme.of(context).cardTheme.color,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
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
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            CupertinoIcons.heart,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ConditionWidget(ad: ad),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${NumberFormat('#,###', 'ru_RU').format(int.parse(ad.price))} тг.',
                      style: textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      ad.city,
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      '${ad.createdAt.day}-${ad.createdAt.month}-${ad.createdAt.year}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
