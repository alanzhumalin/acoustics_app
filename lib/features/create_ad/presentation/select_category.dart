import 'package:flutter/material.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Акустические системы',
      'Гитары',
      'Микрофоны',
      'Синтезаторы',
      'Усилители',
    ];

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Категория',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.of(context).pop(categories[index]),
            leading: const Icon(Icons.speaker),
            title: Text(categories[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
