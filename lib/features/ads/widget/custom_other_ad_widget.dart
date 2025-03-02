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

    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdDetail(ad: widget.ad)));
      },
      child: Container(
        width: size.width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    constraints: BoxConstraints(maxHeight: 190),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        fadeInCurve: Curves.linear,
                        fadeOutCurve: Curves.linear,
                        imageUrl: widget.ad.adImages[0],
                        fit: BoxFit.cover,
                      ),
                    )),
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
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                margin: const EdgeInsets.only(top: 1),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 5, top: 10, bottom: 10),
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
                          const SizedBox(
                            width: 11,
                          ),
                          IconButton(
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
                              color: Color.fromARGB(255, 69, 69, 69),
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
            )
          ],
        ),
      ),
    );
  }
}
