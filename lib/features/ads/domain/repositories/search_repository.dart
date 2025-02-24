abstract class SearchRepository {
  Future<void> saveSearchQuery(String query);
  Future<List<String>> getRecentSearches();
  Future<void> clearRecentSearches();
}
