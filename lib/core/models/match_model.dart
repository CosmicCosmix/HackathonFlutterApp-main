class MatchModel {
  final String id;
  final String title;
  final String subtitle;
  final String matchScore;
  final String description;
  final String interestRate;
  final String amount;
  final String type;
  final List<String> highlights;
  final String processingTime;
  final String eligibility;

  MatchModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.matchScore,
    required this.description,
    required this.interestRate,
    required this.amount,
    required this.type,
    required this.highlights,
    required this.processingTime,
    required this.eligibility,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      matchScore: json['matchScore'] ?? '',
      description: json['description'] ?? '',
      interestRate: json['interestRate'] ?? '',
      amount: json['amount'] ?? '',
      type: json['type'] ?? '',
      highlights: List<String>.from(json['highlights'] ?? []),
      processingTime: json['processingTime'] ?? '',
      eligibility: json['eligibility'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'matchScore': matchScore,
      'description': description,
      'interestRate': interestRate,
      'amount': amount,
      'type': type,
      'highlights': highlights,
      'processingTime': processingTime,
      'eligibility': eligibility,
    };
  }
}

