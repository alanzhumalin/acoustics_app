import 'package:flutter/material.dart';

class MyAds extends StatelessWidget {
  const MyAds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Мои обьявления',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        forceMaterialTransparency: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              shadowColor: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://www.avnow.com/cdn/shop/products/zlx-15bt-800549882057-16302037434443_700x700.jpg?v=1619903489')),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Продам Electro voice ZLX 15 dsfdsfsdfsdf',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '300 000 тг.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0.2,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Редактировать',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.2,
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text('Удалить',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)))),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 23,
            );
          },
          itemCount: 4),
    );
  }
}
