import 'package:acousticsapp/features/ads/domain/repositories/search_repository.dart';

class GetRecentSearches {
  final SearchRepository repository;
  GetRecentSearches({required this.repository});

  Future<List<String>> call() async {
    return await repository.getRecentSearches();
  }
}
