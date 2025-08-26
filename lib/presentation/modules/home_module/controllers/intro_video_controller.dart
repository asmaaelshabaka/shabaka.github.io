// lib/controllers/intro_video_controller.dart
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:shabakahub2025/data/repositories/home_repository.dart';

class IntroVideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;
  final HomeRepository _homeRepository;

  // Rx states
  final RxBool isPlaying = false.obs;
  final RxBool isInitialized = false.obs;
  final RxBool hasError = false.obs;
  final RxBool isLoading = false.obs; // Added loading state

  IntroVideoController(this._homeRepository);

  @override
  void onInit() {
    super.onInit();
    _fetchAndInitializeVideo();
  }

  Future<void> _fetchAndInitializeVideo() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      // Fetch the video URL from repository
      final videoUrl = await _homeRepository.getIntroVideo();

      if (videoUrl == null || videoUrl.isEmpty) {
        throw Exception('No video URL found');
      }

      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
        videoPlayerController.setLooping(true);
        isInitialized.value = true;
      }).catchError((e) {
        print('Video initialization error: $e');
        hasError.value = true;
      });

      videoPlayerController.addListener(_videoListener);
    } catch (e) {
      print('Error fetching video URL: $e');
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void _videoListener() {
    if (isPlaying.value != videoPlayerController.value.isPlaying) {
      isPlaying.value = videoPlayerController.value.isPlaying;
    }
  }

  void togglePlayPause() {
    if (!isInitialized.value) return;

    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
  }

  Future<void> retryLoading() async {
    if (videoPlayerController != null) {
      videoPlayerController.removeListener(_videoListener);
      videoPlayerController.dispose();
    }
    await _fetchAndInitializeVideo();
  }

  @override
  void onClose() {
    videoPlayerController.removeListener(_videoListener);
    videoPlayerController.dispose();
    super.onClose();
  }
}