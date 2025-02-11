import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Правила приложении',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [Text('data')],
      ),
    );
  }
}
