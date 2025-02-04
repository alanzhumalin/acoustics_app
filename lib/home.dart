import 'package:acousticsapp/features/ads/presentation/ad.dart';
import 'package:acousticsapp/features/chat/presentation/chat.dart';
import 'package:acousticsapp/features/create_ad/presentation/create_ad.dart';
import 'package:acousticsapp/features/favorites/presentation/favorites.dart';
import 'package:acousticsapp/features/profile/presentation/profile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    Ad(),
    Chat(),
    CreateAd(),
    Favorites(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          selectedFontSize: 12,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'Главное'),
            BottomNavigationBarItem(
                icon: Stack(children: [
                  Icon(Icons.chat),
                  Positioned(
                      top: -1,
                      right: -1,
                      child: Icon(
                        size: 11,
                        Icons.circle,
                        color: Colors.yellow,
                      ))
                ]),
                label: 'Чат'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Создать'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Избранные'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Профиль')
          ]),
    );
  }
}
