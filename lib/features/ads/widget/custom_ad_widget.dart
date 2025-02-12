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
          Stack(
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
              Positioned(
                  right: 3.5,
                  top: 3.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        Image(height: 30, image: NetworkImage(ad.brandImage)),
                  )),
            ],
          ),
          Padding(
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
          )
        ],
      ),
    );
  }
}
