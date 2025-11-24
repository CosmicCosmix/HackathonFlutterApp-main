class BusinessModel {
  final String id;
  final String name;
  final String fundingNeeded;
  final String expectedReturn;
  final String matchPercentage;
  final String category;
  final String location;
  final String description;
  final String imagePlaceholder;

  BusinessModel({
    required this.id,
    required this.name,
    required this.fundingNeeded,
    required this.expectedReturn,
    required this.matchPercentage,
    required this.category,
    required this.location,
    required this.description,
    required this.imagePlaceholder,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      fundingNeeded: json['fundingNeeded'] ?? '',
      expectedReturn: json['expectedReturn'] ?? '',
      matchPercentage: json['matchPercentage'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      imagePlaceholder: json['imagePlaceholder'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'fundingNeeded': fundingNeeded,
      'expectedReturn': expectedReturn,
      'matchPercentage': matchPercentage,
      'category': category,
      'location': location,
      'description': description,
      'imagePlaceholder': imagePlaceholder,
    };
  }
}

