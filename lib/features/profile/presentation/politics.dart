import 'package:flutter/material.dart';

class Politics extends StatelessWidget {
  const Politics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Политика',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: Text('data'),
    );
  }
}
