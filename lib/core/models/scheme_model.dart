class SchemeModel {
  final String title;
  final String subtitle;
  final String description;
  final String interestRate;
  final String amount;
  final String type;

  SchemeModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.interestRate,
    required this.amount,
    required this.type,
  });

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      interestRate: json['interestRate'] ?? '',
      amount: json['amount'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'interestRate': interestRate,
      'amount': amount,
      'type': type,
    };
  }
}

