import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/profile/presentation/change_ad.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.surfaceContainer;
    final colorDivider = Theme.of(context).colorScheme.onSecondary;
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    final my_ad = ads[0];
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        title: Text(
          'Мои обьявления',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(color: theme),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(12)),
                        height: 130,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                fadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                fadeInCurve: Curves.linear,
                                fadeOutCurve: Curves.linear,
                                imageUrl: my_ad.adImages[0])),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Создано ${my_ad.createdAt.day}/${my_ad.createdAt.month}/${my_ad.createdAt.year}',
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              maxLines: 2,
                              my_ad.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ConditionWidget(ad: my_ad),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${NumberFormat('#,###', 'ru_RU').format(int.parse(my_ad.price))} тг.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.2,
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 116, 211),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeAd(
                                            ad: my_ad,
                                          )));
                            },
                            child: Text(
                              'Редактировать',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.2,
                                backgroundColor:
                                    const Color.fromARGB(255, 214, 45, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {},
                              child: Text('Убрать',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)))),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: colorDivider,
              height: 0,
              thickness: 1.7,
            );
          },
          itemCount: 4),
    );
  }
}
