import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchLocalDataSource {
  Future<void> saveSearchQuery(String query);
  Future<List<String>> getRecentSearches();
  Future<void> clearRecentSearches();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  static const String _keyRecentSearches = 'resent_searches';

  @override
  Future<void> saveSearchQuery(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? recentSearches =
        prefs.getStringList(_keyRecentSearches) ?? [];

    recentSearches.remove(query);
    recentSearches.insert(0, query);
    if (recentSearches.length > 10) {
      recentSearches = recentSearches.sublist(0, 10);
    }
    await prefs.setStringList(_keyRecentSearches, recentSearches);
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_keyRecentSearches) ?? [];
  }

  @override
  Future<void> clearRecentSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyRecentSearches);
  }
}
