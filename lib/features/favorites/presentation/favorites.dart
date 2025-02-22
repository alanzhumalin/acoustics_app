import 'package:acousticsapp/features/favorites/widget/shimmer_loading_favorites.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favorites extends ConsumerWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme.surfaceContainer;
    final colorDivider = Theme.of(context).colorScheme.onSecondary;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Избранное',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 4,
              color: colorDivider,
              thickness: 2,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: theme,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/speakers/k1.jpeg')),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Продам L acoustics k1',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Состояние топ покупали как новую L acoustics k1',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.heart_fill,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(height: 0, thickness: 1.2, color: colorDivider)
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
