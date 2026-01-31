class ReviewModel {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userName: json['userName'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
