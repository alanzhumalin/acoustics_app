import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/ads/presentation/image_full_screen.dart';
import 'package:acousticsapp/shared/widgets/condition_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetail extends StatefulWidget {
  const AdDetail({super.key, required this.ad});
  final AdModel ad;

  @override
  State<AdDetail> createState() => _AdDetailState();
}

class _AdDetailState extends State<AdDetail> {
  final PageController pageController = PageController();
  int initialIndex = 0;
  Future<void> _makeCall(String phoneNumber) async {
    final Uri phoneUrl = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      throw 'Не удалось совершить звонок';
    }
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        initialIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height: size.height * 0.4,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: widget.ad.adImages.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          final int indexFrom = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ImageFullScreen(
                                  imagesLink: widget.ad.adImages,
                                  indexInitial: index,
                                ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ));
                          setState(() {
                            pageController.jumpToPage(indexFrom);
                          });
                        },
                        child: Image.network(
                          widget.ad.adImages[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
            SizedBox(
              height: 13,
            ),
            if (widget.ad.adImages.length != 1)
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    widget.ad.adImages.length,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Container(
                            width: initialIndex == index ? 7 : 5,
                            height: initialIndex == index ? 7 : 5,
                            decoration: BoxDecoration(
                                color: initialIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                                shape: BoxShape.circle),
                          ),
                        )),
              )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ad.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(height: 35, widget.ad.brandImage)),
                    SizedBox(
                      width: 10,
                    ),
                    ConditionWidget(ad: widget.ad),
                  ]),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${NumberFormat('#,###', 'ru_RU').format(int.parse(widget.ad.price))} тг.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Опубликован ${widget.ad.createdAt.month}-${widget.ad.createdAt.day}-${widget.ad.createdAt.year}. ${widget.ad.city}',
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
                    widget.ad.description,
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
                              widget.ad.nameOfCustomer,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Пользователь зарегестрирован с ${widget.ad.createdAt.month}-${widget.ad.createdAt.day}-${widget.ad.createdAt.year}',
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
                  _makeCall(widget.ad.phoneNumber);
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
