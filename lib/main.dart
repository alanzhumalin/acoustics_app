import 'package:acousticsapp/core/theme/theme.dart';
import 'package:acousticsapp/core/theme/theme_cubit.dart';
import 'package:acousticsapp/features/ads/data/repositories/search_repository_impl.dart';
import 'package:acousticsapp/features/ads/domain/usecases/clear_recent_searches.dart';
import 'package:acousticsapp/features/ads/domain/usecases/get_recent_searches.dart';
import 'package:acousticsapp/features/ads/domain/usecases/save_search_query.dart';
import 'package:acousticsapp/features/ads/presentation/cubit/scroll_cubit.dart';
import 'package:acousticsapp/features/ads/presentation/cubit/recent_search_cubit.dart';
import 'package:acousticsapp/features/ads/presentation/cubit/search_cubit.dart';
import 'package:acousticsapp/home.dart';
import 'package:acousticsapp/shared/bloc/index_bottom_nav_bar.dart';
import 'package:acousticsapp/shared/bloc/scroll_home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/ads/data/datasources/search_local_data_source.dart';

void main() {
  final searchLocalDataSource = SearchLocalDataSourceImpl();
  final searchRepository =
      SearchRepositoryImpl(localDataSource: searchLocalDataSource);
  final getRecentSearches = GetRecentSearches(repository: searchRepository);
  final saveSearchQuery = SaveSearchQuery(repository: searchRepository);
  final clearRecentSearches = ClearRecentSearches(repository: searchRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ScrollLinearCubit()),
        BlocProvider(create: (_) => ScrollHomeCubit()),
        BlocProvider(create: (_) => IndexBottomNavBar()),
        BlocProvider(create: (_) => SearchCubit()),
        BlocProvider(
            create: (_) => RecentSearchCubit(
                  getRecentSearches: getRecentSearches,
                  saveSearchQuery: saveSearchQuery,
                  clearRecentSearches: clearRecentSearches,
                )..loadRecentSearches()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final themeCubit = context.watch<ThemeCubit>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: blackTheme,
          themeMode: themeMode,
          theme: themeCubit.themeData,
          home: Home(),
        );
      },
    );
  }
}
