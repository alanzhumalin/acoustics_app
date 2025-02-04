import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/presentation/image_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetail extends StatelessWidget {
  const AdDetail({super.key, required this.ad});
  final AdModel ad;
  Future<void> _makeCall(String phoneNumber) async {
    final Uri phoneUrl = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      throw 'Не удалось совершить звонок';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Детали объявления',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width > 358 ? 20 : 16),
        ),
        forceMaterialTransparency: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImageFullScreen(imageLink: ad.imageLink),
                  ),
                );
              },
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.4,
                child: Image.network(
                  ad.imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${NumberFormat('#,###', 'ru_RU').format(int.parse(ad.price))} тг.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Опубликован ${ad.createdAt.month}-${ad.createdAt.day}-${ad.createdAt.year}. ${ad.city}',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Text(
                    'ОПИСАНИЕ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    ad.description,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Text(
                    'ПРОДАВЕЦ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 40,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ad.nameOfCustomer,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Пользователь зарегестрирован с ${ad.createdAt.month}-${ad.createdAt.day}-${ad.createdAt.year}',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _makeCall(ad.phoneNumber);
                },
                icon: const Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                ),
                label: Text('Позвонить',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.blue),
                child: Text(
                  'Сообщение',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
