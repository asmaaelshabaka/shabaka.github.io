// lib/data/models/enrollment_model.dart
class EnrollmentModel {
  final String id;
  final String userId; // Connection: ID of the user who enrolled
  final String courseId; // Connection: ID of the course enrolled in
  final DateTime enrollmentDate;
  final String status; // e.g., 'active', 'completed', 'dropped'
  final double progress; // e.g., 0.0 to 1.0 (0% to 100%)

  EnrollmentModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.enrollmentDate,
    this.status = 'active',
    this.progress = 0.0,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      enrollmentDate: DateTime.parse(json['enrollmentDate'] as String),
      status: json['status'] as String? ?? 'active',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'enrollmentDate': enrollmentDate.toIso8601String(),
      'status': status,
      'progress': progress,
    };
  }

  EnrollmentModel copyWith({
    String? id,
    String? userId,
    String? courseId,
    DateTime? enrollmentDate,
    String? status,
    double? progress,
  }) {
    return EnrollmentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      status: status ?? this.status,
      progress: progress ?? this.progress,
    );
  }

  @override
  String toString() {
    return 'EnrollmentModel(id: $id, userId: $userId, courseId: $courseId, status: $status)';
  }
}