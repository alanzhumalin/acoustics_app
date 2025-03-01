import 'package:acousticsapp/features/ads/data/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchState {
  final List<Category> results;
  final String query;
  final bool isSearchSelected;
  final bool isCursorShown;

  const SearchState({
    required this.results,
    required this.query,
    required this.isSearchSelected,
    required this.isCursorShown,
  });

  SearchState copyWith({
    List<Category>? results,
    String? query,
    bool? isSearchSelected,
    bool? isCursorShown,
  }) {
    return SearchState(
      results: results ?? this.results,
      query: query ?? this.query,
      isSearchSelected: isSearchSelected ?? this.isSearchSelected,
      isCursorShown: isCursorShown ?? this.isCursorShown,
    );
  }
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit()
      : super(const SearchState(
          results: [],
          query: '',
          isSearchSelected: false,
          isCursorShown: false,
        ));

  final TextEditingController searchController = TextEditingController();

  void search(String query) {
    List<Category> filteredResults = query.isEmpty
        ? []
        : categories
            .where((category) =>
                category.category.toLowerCase().contains(query.toLowerCase()))
            .toList();

    emit(state.copyWith(results: filteredResults, query: query));
  }

  void toggleSearch(bool isSelected) {
    emit(state.copyWith(
        isSearchSelected: isSelected, isCursorShown: isSelected));
  }

  void clearSearch() {
    searchController.clear();
    emit(state.copyWith(
        results: [], query: '', isSearchSelected: false, isCursorShown: false));
  }
}
