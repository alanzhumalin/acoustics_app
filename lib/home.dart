import 'package:acousticsapp/features/ads/presentation/ad.dart';
import 'package:acousticsapp/features/chat/presentation/chat.dart';
import 'package:acousticsapp/features/create_ad/presentation/create_ad.dart';
import 'package:acousticsapp/features/favorites/presentation/favorites.dart';
import 'package:acousticsapp/features/profile/presentation/profile.dart';
import 'package:acousticsapp/shared/provider/page_scroll_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
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
    final _pageScrollController = ref.read(pageScrollController);
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
          if (value == 0 && selectedIndex == 0) {
            _pageScrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          }

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
