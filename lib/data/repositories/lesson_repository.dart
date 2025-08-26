import 'package:shabakahub2025/data/models/lesson_model.dart';

import '../providers/lessons_provider.dart';

class LessonRepository {
  final LessonProvider _lessonProvider;

  LessonRepository(this._lessonProvider);
  Future<List<LessonModel>> getLessonsByIds(List<String> lessonIds) async {
    try {
      return await _lessonProvider.getLessonsByIds(lessonIds);
    } catch (e) {
      throw Exception(
        'Failed to fetch lessons from repository: ${e.toString()}',
      );
    }
  }
}
