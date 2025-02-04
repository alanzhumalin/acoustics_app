class CategoryModel {
  final String category;
  final String assets;

  const CategoryModel({required this.assets, required this.category});
}

List<CategoryModel> categories = [
  CategoryModel(
      assets: 'assets/categories/microphone.webp', category: 'Микрофон'),
  CategoryModel(assets: 'assets/categories/speakers.jpeg', category: 'Колонки'),
  CategoryModel(assets: 'assets/categories/mixer.webp', category: 'Микшер'),
  CategoryModel(
      assets: 'assets/categories/instrumental.avif', category: 'Инструмент'),
];
