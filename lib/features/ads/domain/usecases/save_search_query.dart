import 'package:acousticsapp/features/ads/domain/repositories/search_repository.dart';

class SaveSearchQuery {
  final SearchRepository repository;
  SaveSearchQuery({required this.repository});

  Future<void> call(String query) async {
    await repository.saveSearchQuery(query);
  }
}
