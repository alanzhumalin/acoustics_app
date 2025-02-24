import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final colorDivider = Theme.of(context).colorScheme.onSecondary;
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    return Scaffold(
      backgroundColor: backgroundcolor,
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
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: containerColor,
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
                                  fontSize: 14, fontWeight: FontWeight.bold),
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
    );
  }
}
