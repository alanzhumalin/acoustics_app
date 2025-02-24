import 'package:acousticsapp/features/ads/domain/repositories/search_repository.dart';

class ClearRecentSearches {
  final SearchRepository repository;
  ClearRecentSearches({required this.repository});

  Future<void> call() async {
    await repository.clearRecentSearches();
  }
}
