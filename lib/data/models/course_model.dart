// lib/data/models/course_model.dart
class CourseModel {
  final String id;
  final String title;
  final String? description;
  final String? imageUrl;
  final double? price;
  final String? instructor;
  final String? instructorId;
  final int? durationMinutes;
  final List<String>? lessonIds; // Array of strings
  final double? rating;
  final int? reviewsCount;
  final String? introVideoUrl;
  final String categoryId; // To link courses to categories

  CourseModel({
    required this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.price,
    this.instructor,
    this.instructorId,
    this.durationMinutes,
    this.lessonIds,
    this.rating,
    this.reviewsCount,
    this.introVideoUrl,
    required this.categoryId,
  });

  // Factory constructor to create a CourseModel from a Firestore Map
  factory CourseModel.fromMap(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num?)?.toDouble(), // Handle num to double conversion
      instructor: json['instructor'] as String?,
      instructorId: json['instructorId'] as String?,
      durationMinutes: json['durationMinutes'] as int?,
      // Ensure lessonIds is cast to List<String>
      lessonIds: (json['lessonIds'] as List?)?.map((e) => e.toString()).toList(),
      rating: (json['rating'] as num?)?.toDouble(), // Handle num to double conversion
      reviewsCount: json['reviewsCount'] as int?,
      introVideoUrl: json['introVideoUrl'] as String?,
      categoryId: json['categoryId'] as String,
    );
  }

  // Method to convert a CourseModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'instructor': instructor,
      'instructorId': instructorId,
      'durationMinutes': durationMinutes,
      'lessonIds': lessonIds,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'introVideoUrl': introVideoUrl,
      'categoryId': categoryId,
    };
  }

  // Optional: copyWith method for immutability and easy updates
  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    double? price,
    String? instructor,
    String? instructorId,
    int? durationMinutes,
    List<String>? lessonIds,
    double? rating,
    int? reviewsCount,
    String? introVideoUrl,
    String? categoryId,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      instructor: instructor ?? this.instructor,
      instructorId: instructorId ?? this.instructorId,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      lessonIds: lessonIds ?? this.lessonIds,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      introVideoUrl: introVideoUrl ?? this.introVideoUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  String toString() {
    return 'CourseModel(id: $id, title: $title, categoryId: $categoryId)';
  }
}
