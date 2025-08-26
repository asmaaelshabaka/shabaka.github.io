// lib/modules/course_module/bindings/free_video_binding.dart
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/free_videos_controller.dart';

class FreeVideoBinding extends Bindings {
  @override
  void dependencies() {
    // This assumes FreeVideoRepository is already in AppBinding
    // GetX will find the instance automatically
    Get.lazyPut<FreeVideosListController>(
          () => FreeVideosListController(),
    );

  }

}