// lib/data/providers/free_video_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shabakahub2025/data/models/free_videos_model.dart';
import 'package:shabakahub2025/utils/app_environment.dart';

/// Provides methods to interact with the 'freevideos' collection in Firestore.
class FreeVideoProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetches a list of all free videos from Firestore.
  Future<List<FreeVideoModel>> getAllFreeVideos() async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final collectionPath = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('freevideos');

      final querySnapshot = await collectionPath.get();

      return querySnapshot.docs
          .map((doc) => FreeVideoModel.fromDocument(doc))
          .toList();
    } catch (e) {
      print('Error loading all free videos from Firestore: $e');
      throw Exception('Failed to load all free videos from Firestore.');
    }
  }

  /// Fetches a list of free videos for a specific category ID.
  Future<List<FreeVideoModel>> getFreeVideosByCategoryId(String categoryId) async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final collectionPath = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('freevideos');

      // Create a query to filter documents by categoryId.
      final querySnapshot = await collectionPath
          .where('categoryId', isEqualTo: categoryId)
          .get();

      return querySnapshot.docs
          .map((doc) => FreeVideoModel.fromDocument(doc))
          .toList();
    } catch (e) {
      print('Error loading free videos for category $categoryId from Firestore: $e');
      throw Exception('Failed to load videos for category from Firestore.');
    }
  }
}
