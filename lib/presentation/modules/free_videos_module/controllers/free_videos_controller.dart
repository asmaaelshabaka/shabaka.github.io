import 'dart:convert';
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/free_videos_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../data/repositories/free_videos_repository.dart';

class FreeVideosListController extends GetxController {
  final FreeVideoRepository _freeVideoRepository =
  Get.find<FreeVideoRepository>();

  final RxList<FreeVideoModel> freeVideos = <FreeVideoModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  String? freecategoryId;
  String? categoryName;

  bool get hasError => errorMessage.isNotEmpty;
  bool get isEmpty => freeVideos.isEmpty && !isLoading.value;

  // -- VIDEO PLAYER STATE & METHODS --
  String? currentVideoId;
  late YoutubePlayerController youtubeController;

  String? _extractVideoId(String urlOrId) {
    try {
      final decodedBytes = base64.decode(urlOrId);
      final decodedString = utf8.decode(decodedBytes);
      return YoutubePlayerController.convertUrlToId(decodedString);
    } catch (e) {
      return YoutubePlayerController.convertUrlToId(urlOrId);
    }
  }

  Future<void> playVideo(String url) async {
    final String? videoId = _extractVideoId(url);

    if (videoId != null && currentVideoId != videoId) {
      currentVideoId = videoId;
      await youtubeController.loadVideoById(videoId: videoId);
      update(['youtubePlayer']);
    } else if (videoId == null) {
      print('Invalid YouTube URL: $url');
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('FreeVideosListController initialized.');

    youtubeController = YoutubePlayerController(
      params: const YoutubePlayerParams(

        //autoPlay: false,
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    // // Listen for player ready state
    // youtubeController.onEnterFullscreen = () {
    //   // Handle fullscreen mode if needed
    // };

    if (Get.parameters.containsKey('free_categoryId')) {
      freecategoryId = Get.parameters['free_categoryId'];
      categoryName = Get.parameters['free_categoryName'];
      print('FreeVideosListController initialized for category: $categoryName (ID: $freecategoryId)');

      if (freecategoryId != null) {
        fetchFreeVideosByCategoryId(freecategoryId!);
      } else {
        errorMessage.value = 'Invalid category ID.';
        isLoading.value = false;
      }
    } else {
      errorMessage.value = 'No category ID provided.';
      isLoading.value = false;
      print('Error: FreeVideosListController initialized without categoryId.');
    }
  }

  @override
  void onClose() {
    youtubeController.close();
    super.onClose();
  }

  Future<void> fetchFreeVideosByCategoryId(String id) async {
    isLoading.value = true;
    errorMessage.value = '';
    freeVideos.clear();
    try {
      final fetchedVideos = await _freeVideoRepository.getFreeVideosByCategoryId(id);
      freeVideos.assignAll(fetchedVideos);
      print('Fetched ${fetchedVideos.length} free videos for category $id.');

      if (freeVideos.isNotEmpty) {
        playVideo(freeVideos.first.videoUrl);
      }
    } catch (e) {
      print('Error fetching free videos by category ID $id: $e');
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}