class CategorySelection {
  final String category;
  final String subcategory;
  final String item;
  final String brand;
  final String brandImage;

  CategorySelection({
    required this.category,
    required this.subcategory,
    required this.item,
    required this.brand,
    required this.brandImage,
  });

  factory CategorySelection.fromJson(Map<String, dynamic> json) {
    return CategorySelection(
      category: json['category'] ?? '',
      subcategory: json['subcategory'] ?? '',
      item: json['item'] ?? '',
      brand: json['brand'] ?? '',
      brandImage: json['brandImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'subcategory': subcategory,
      'item': item,
      'brand': brand,
      'brandImage': brandImage,
    };
  }
}
