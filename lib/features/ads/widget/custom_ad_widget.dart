import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
                    placeholder: (context, url) {
                      return SizedBox(
                        width: double.infinity,
                        height: 180,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Container(
                            color: const Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                      );
                    },
                    imageUrl: widget.ad.adImages[0],
                    fit: BoxFit.contain,
                  )),
                ),
              ),
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
            child: Stack(
              children: [
                Card(
                  shadowColor: Colors.transparent,
                  margin: EdgeInsets.all(0),
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
                            IconButton(
                              isSelected: isSelected,
                              padding: EdgeInsets.zero,
                              constraints:
                                  BoxConstraints(minHeight: 10, minWidth: 40),
                              style: const ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              selectedIcon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                              icon: Icon(
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
