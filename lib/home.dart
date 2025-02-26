import 'package:acousticsapp/features/ads/presentation/ads.dart';
import 'package:acousticsapp/features/chat/presentation/chat.dart';
import 'package:acousticsapp/features/create_ad/presentation/create_ad.dart';
import 'package:acousticsapp/features/favorites/presentation/favorites.dart';
import 'package:acousticsapp/features/profile/presentation/profile.dart';
import 'package:acousticsapp/shared/bloc/index_bottom_nav_bar.dart';
import 'package:acousticsapp/shared/bloc/scroll_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static final List<Widget> _pages = [
    Ads(),
    Chat(),
    CreateAd(),
    Favorites(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme.backgroundColor;
    final scrollCubit = context.read<ScrollHomeCubit>();
    // final indexCubit = context.read<IndexBottomNavBar>();
    // final page = context.watch<IndexBottomNavBar>();
    return Scaffold(
      body: BlocBuilder<IndexBottomNavBar, int>(builder: (context, index) {
        return _pages[index];
      }),
      bottomNavigationBar:
          BlocBuilder<IndexBottomNavBar, int>(builder: (context, index) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          selectedFontSize: 12,
          onTap: (value) {
            if (value == 0 && index == 0) {
              scrollCubit.scrollToTop();
            }
            context.read<IndexBottomNavBar>().indexChange(value);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(index == 0 ? Icons.home_filled : Icons.home_outlined),
              label: 'Главное',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                      index == 1
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
                    ),
                  ),
                ],
              ),
              label: 'Чат',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  index == 2 ? Icons.add_circle : Icons.add_circle_outline),
              label: 'Создать',
            ),
            BottomNavigationBarItem(
              icon: Icon(index == 3 ? Icons.favorite : Icons.favorite_border),
              label: 'Избранные',
            ),
            BottomNavigationBarItem(
              icon: Icon(index == 4 ? Icons.person : Icons.person_outline),
              label: 'Профиль',
            ),
          ],
        );
      }),
    );
  }
}
