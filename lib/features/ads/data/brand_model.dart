class BrandModel {
  final String name;

  final String logo;

  BrandModel({required this.logo, required this.name});

  factory BrandModel.fromMap(Map<String, dynamic> json) {
    return BrandModel(logo: json['name'], name: json['logo']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logo,
    };
  }
}
