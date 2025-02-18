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
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme.backgroundColor;
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: theme,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        selectedFontSize: 12,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined),
            label: 'Главное',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                    selectedIndex == 1
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                    color: Colors.orange),
                Positioned(
                    top: -12,
                    right: -4,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.yellow, shape: BoxShape.circle),
                      child: Text(
                        '1',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.brown[800],
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            label: 'Чат',
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedIndex == 2
                ? Icons.add_circle
                : Icons.add_circle_outline),
            label: 'Создать',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                selectedIndex == 3 ? Icons.favorite : Icons.favorite_border),
            label: 'Избранные',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(selectedIndex == 4 ? Icons.person : Icons.person_outline),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
