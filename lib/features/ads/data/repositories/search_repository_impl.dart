import 'package:acousticsapp/features/ads/data/datasources/search_local_data_source.dart';
import 'package:acousticsapp/features/ads/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource localDataSource;
  SearchRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveSearchQuery(String query) async {
    await localDataSource.saveSearchQuery(query);
  }

  @override
  Future<List<String>> getRecentSearches() async {
    return await localDataSource.getRecentSearches();
  }

  @override
  Future<void> clearRecentSearches() async {
    await localDataSource.clearRecentSearches();
  }
}
