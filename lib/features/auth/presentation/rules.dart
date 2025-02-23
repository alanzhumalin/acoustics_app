import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Правила использования',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'ПРАВИЛА ИСПОЛЬЗОВАНИЯ ПРИЛОЖЕНИЯ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '1. Общие положения:\n'
              '1.1. Используя приложение, вы принимаете данные правила.\n'
              '1.2. Платформа предназначена для продажи товаров акустических систем.\n\n'
              '2. Размещение объявлений:\n'
              '2.1. Объявления должны соответствовать тематике акустики.\n'
              '2.2. Указывайте достоверную информацию о товаре.\n\n'
              '3. Запрещённые действия:\n'
              '3.1. Публикация фальшивых объявлений.\n'
              '3.2. Реклама не связанных товаров.\n\n'
              '4. Ответственность сторон:\n'
              '4.1. Администрация не несёт ответственности за сделки.\n'
              '4.2. Пользователь отвечает за достоверность данных.\n\n'
              '5. Конфиденциальность:\n'
              '5.1. Персональные данные обрабатываются согласно Политике конфиденциальности.\n\n'
              '6. Изменение правил:\n'
              '6.1. Использование после изменения правил означает согласие.\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
