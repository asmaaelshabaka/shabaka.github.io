// lib/data/models/review_model.dart
class ReviewModel {
  final String id;
  final String userId; // Connection: ID of the user who submitted the review
  final String courseId; // Connection: ID of the course being reviewed
  final int rating; // Rating (e.g., 1 to 5 stars)
  final String? comment; // Optional: Textual review
  final DateTime reviewDate;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.rating,
    this.comment,
    required this.reviewDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String?,
      reviewDate: DateTime.parse(json['reviewDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'rating': rating,
      'comment': comment,
      'reviewDate': reviewDate.toIso8601String(),
    };
  }

  ReviewModel copyWith({
    String? id,
    String? userId,
    String? courseId,
    int? rating,
    String? comment,
    DateTime? reviewDate,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      reviewDate: reviewDate ?? this.reviewDate,
    );
  }

  @override
  String toString() {
    return 'ReviewModel(id: $id, userId: $userId, courseId: $courseId, rating: $rating)';
  }
}