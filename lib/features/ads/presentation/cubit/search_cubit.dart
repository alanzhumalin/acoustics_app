import 'package:acousticsapp/features/ads/domain/usecases/clear_recent_searches.dart';
import 'package:acousticsapp/features/ads/domain/usecases/get_recent_searches.dart';
import 'package:acousticsapp/features/ads/domain/usecases/save_search_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<List<String>> {
  final GetRecentSearches getRecentSearches;
  final SaveSearchQuery saveSearchQuery;
  final ClearRecentSearches clearRecentSearches;
  SearchCubit(
      {required this.getRecentSearches,
      required this.clearRecentSearches,
      required this.saveSearchQuery})
      : super([]);

  Future<void> loadRecentSearches() async {
    final searches = await getRecentSearches();
    emit(searches);
  }

  Future<void> clearSearches() async {
    await clearRecentSearches();
    emit([]);
  }

  Future<void> saveQuery(String query) async {
    await saveSearchQuery(query);
    await loadRecentSearches();
  }
}
