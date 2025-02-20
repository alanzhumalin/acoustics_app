import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/presentation/ad_detail.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomOtherAdWidget extends StatefulWidget {
  const CustomOtherAdWidget({super.key, required this.ad});
  final AdModel ad;

  @override
  State<CustomOtherAdWidget> createState() => _CustomOtherAdWidgetState();
}

class _CustomOtherAdWidgetState extends State<CustomOtherAdWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final borderColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdDetail(ad: widget.ad)));
      },
      child: Container(
        width: size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.2, color: borderColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    height: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: widget.ad.adImages[0],
                        fit: BoxFit.contain,
                      ),
                    )),
                Positioned(
                    right: 3.5,
                    top: 3.5,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.ad.categorySelection.brandImage,
                          height: 30,
                        ))),
              ],
            ),
            Expanded(
              child: Card(
                shadowColor: Colors.transparent,
                margin: EdgeInsets.only(top: 1),
                color: Theme.of(context).cardTheme.color,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 5,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.ad.title,
                              style: textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            child: isSelected
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    color:
                                        const Color.fromARGB(255, 69, 69, 69),
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
            )
          ],
        ),
      ),
    );
  }
}
