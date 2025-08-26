// lib/data/repositories/free_video_repository.dart
import 'package:shabakahub2025/data/models/free_videos_model.dart';

import '../providers/free_videos_provider.dart';

/// The repository abstracts the data source logic for free videos.
/// It provides a clean API for the controller to fetch data.
class FreeVideoRepository {
  final FreeVideoProvider _freeVideoProvider;

  FreeVideoRepository(this._freeVideoProvider);

  /// Fetches a list of all free videos.
  Future<List<FreeVideoModel>> getAllFreeVideos() async {
    try {
      return await _freeVideoProvider.getAllFreeVideos();
    } catch (e) {
      throw Exception('Failed to fetch all free videos from repository: ${e.toString()}');
    }
  }

  /// Fetches a list of free videos filtered by a specific category ID.
  Future<List<FreeVideoModel>> getFreeVideosByCategoryId(String categoryId) async {
    try {
      return await _freeVideoProvider.getFreeVideosByCategoryId(categoryId);
    } catch (e) {
      throw Exception('Failed to fetch free videos by category ID from repository: ${e.toString()}');
    }
  }
}
