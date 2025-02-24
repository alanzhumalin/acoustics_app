import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Ваши уведомления',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(color: containerColor),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ваш пришло сообщение от Alan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '31/03/2025',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 0,
                    color: const Color.fromARGB(255, 65, 65, 65),
                  )
                ],
              ),
            );
          }),
    );
  }
}
