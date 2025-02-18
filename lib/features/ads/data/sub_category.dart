class Subcategory {
  final String subcategory;
  final List<String> items;

  Subcategory({
    required this.subcategory,
    required this.items,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      subcategory: json['subcategory'] ?? '',
      items: List<String>.from(json['items'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subcategory': subcategory,
      'items': items,
    };
  }
}
