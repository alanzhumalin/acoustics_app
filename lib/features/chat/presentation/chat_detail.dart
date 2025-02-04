import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetail extends ConsumerStatefulWidget {
  const ChatDetail({super.key});

  @override
  ConsumerState<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends ConsumerState<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Чат',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        forceMaterialTransparency: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Здравствуйте, как могу помочь?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blueGrey[600],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Продаю L acoustics K1.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
