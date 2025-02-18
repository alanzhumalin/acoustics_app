import 'category.dart';

class CategoryModel {
  final List<Category> categories;

  CategoryModel({required this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categories: (json['categories'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}
