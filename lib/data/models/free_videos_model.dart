// lib/data/models/free_videos_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single free video from the Firestore database.
/// This model maps the data from Firestore documents to a Dart object.
class FreeVideoModel {
  final String id;
  final String title;
  final String? description; // Assuming a description might exist
  final String videoUrl;
  final String thumbnailUrl;
  final String categoryId;

  FreeVideoModel({
    required this.id,
    required this.title,
    this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.categoryId,
  });

  /// Factory constructor to create a FreeVideoModel from a Firestore document snapshot.
  /// It safely handles nullable fields and ensures all required fields are present.
  factory FreeVideoModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FreeVideoModel(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String?,
      videoUrl: data['videoUrl'] as String,
      thumbnailUrl: data['thumbnailUrl'] as String,
      categoryId: data['categoryId'] as String,
    );
  }

  /// Method to convert a FreeVideoModel object to a Map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'categoryId': categoryId,
    };
  }

  @override
  String toString() {
    return 'FreeVideoModel(id: $id, title: $title, categoryId: $categoryId)';
  }
}
