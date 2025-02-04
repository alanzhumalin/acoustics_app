import 'package:acousticsapp/features/chat/presentation/chat_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Chat extends ConsumerWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme.surfaceContainer;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Чаты',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
          itemCount: 4,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 12,
            );
          },
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatDetail()));
              },
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    color: theme,
                    child: Row(
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
                                'Alex Sanches',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Продам L acoustics k1',
                                style: TextStyle(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '???',
                                style: TextStyle(fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Text(
                          '23.01.2012',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 5,
                      top: 5,
                      child: Icon(
                        size: 18,
                        Icons.circle_rounded,
                        color: Colors.blue,
                      ))
                ],
              ),
            );
          }),
    );
  }
}
