import 'business_model.dart';

class DashboardCategoryModel {
  final String id;
  final String title;
  final String icon;
  final List<BusinessModel> businesses;

  DashboardCategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.businesses,
  });

  factory DashboardCategoryModel.fromJson(Map<String, dynamic> json) {
    return DashboardCategoryModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      businesses: (json['businesses'] as List<dynamic>?)
              ?.map((item) => BusinessModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'businesses': businesses.map((b) => b.toJson()).toList(),
    };
  }
}

