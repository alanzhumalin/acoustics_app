import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> showFilterDialog(
    BuildContext context, Function(String) onSort) async {
  return await showCupertinoModalPopup<String>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: const Text('Фильтр'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Сначала дешевле',
                style: TextStyle(color: Colors.blue)),
            onPressed: () {
              onSort('price_ascending');
              Navigator.of(context).pop('Сначала дешевле');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Сначала дороже',
                style: TextStyle(color: Colors.blue)),
            onPressed: () {
              onSort('price_descending');
              Navigator.of(context).pop('Сначала дороже');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Сначала новые объявления',
                style: TextStyle(color: Colors.blue)),
            onPressed: () {
              onSort('date_descending');
              Navigator.of(context).pop('Сначала новые объявления');
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Сначала старые объявления',
                style: TextStyle(color: Colors.blue)),
            onPressed: () {
              onSort('date_ascending');
              Navigator.of(context).pop('Сначала старые объявления');
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Отмена', style: TextStyle(color: Colors.red)),
        ),
      );
    },
  );
}
