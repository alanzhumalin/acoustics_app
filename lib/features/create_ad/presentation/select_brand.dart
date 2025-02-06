import 'package:flutter/material.dart';

class SelectBrand extends StatelessWidget {
  const SelectBrand({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> brands = [
      'L Acoustics',
      'Electro-voice',
      'Shure',
      'Yamaha',
      'Dynacord',
    ];

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Бренды',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.of(context).pop(brands[index]),
            leading: const Icon(Icons.speaker),
            title: Text(brands[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
