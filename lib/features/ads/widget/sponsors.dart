import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxzTulqQqJsqo-S-zZ4UAEiRGBJXY6cV4nMXC8vXoITNVQmnv575S6BHf36aQY53Ok_SY&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5MZWsPFiO9W2waP-Y22BtncEkyH-YDV4LZQ&s',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYWQhDPeRyiKSnxVSmvcIKu-btpznhjh9PpQ&s',
];

class Sponsors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Реклама',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 100,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imgList.map((e) {
                return Image.network(e,
                    fit: BoxFit.fitHeight, width: double.infinity);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
