// lib/data/models/lesson_model.dart
class LessonModel {
  final String id;
  final String courseId; // Connection: ID of the course this lesson belongs to
  final String title;
  final String description;
  final String videoUrl;
  final int durationSeconds;
  final int order;
  final String contentType;
  final String? textContent;
  final List<String>? resources;
  final bool isCompleted; // Client-side state

  LessonModel({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.durationSeconds,
    required this.order,
    this.contentType = 'video',
    this.textContent,
    this.resources,
    this.isCompleted = false,
  });

  factory LessonModel.fromMap(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String,
      durationSeconds: json['durationSeconds'] as int,
      order: json['order'] as int,
      contentType: json['contentType'] as String? ?? 'video',
      textContent: json['textContent'] as String?,
      resources: List<String>.from(json['resources'] ?? []),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'durationSeconds': durationSeconds,
      'order': order,
      'contentType': contentType,
      'textContent': textContent,
      'resources': resources,
      'isCompleted': isCompleted,
    };
  }

  LessonModel copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    String? videoUrl,
    int? durationSeconds,
    int? order,
    String? contentType,
    String? textContent,
    List<String>? resources,
    bool? isCompleted,
  }) {
    return LessonModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      order: order ?? this.order,
      contentType: contentType ?? this.contentType,
      textContent: textContent ?? this.textContent,
      resources: resources ?? this.resources,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'LessonModel(id: $id, courseId: $courseId, title: $title, order: $order)';
  }
}