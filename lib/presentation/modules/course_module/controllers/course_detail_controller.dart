// lib/modules/course_module/controllers/course_detail_controller.dart
import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/course_model.dart';
import 'package:shabakahub2025/data/models/lesson_model.dart';
import 'package:shabakahub2025/data/repositories/lesson_repository.dart';
import 'package:shabakahub2025/presentation/modules/auth_module/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/repositories/course_repository.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';

class CourseDetailController extends GetxController {
  final CourseRepository _courseRepository = Get.find<CourseRepository>();
  final LessonRepository _lessonRepository = Get.find<LessonRepository>();
  final AuthController _authController = Get.find<AuthController>();

  final Rx<CourseModel?> _course = Rx<CourseModel?>(null);
  CourseModel? get course => _course.value;

  final RxList<LessonModel> _lessons = <LessonModel>[].obs;
  List<LessonModel> get lessons => _lessons.value;

  final RxBool isLoading = true.obs;
  final RxInt currentStep = 0.obs;

  late VideoPlayerController videoPlayerController;
  late RxBool isVideoInitialized = false.obs;
  late RxBool isPlaying = false.obs;
  late RxBool showControls = true.obs;
  late Rx<Duration> videoPosition = Duration.zero.obs;
  late Rx<Duration> videoDuration = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    // <--- CORRECTION HERE: Retrieve the ID using Get.arguments --->
    final dynamic argument = Get.arguments;
    String? courseId;
    if (argument is String) {
      courseId = argument;
    }

    if (courseId != null) {
      fetchCourseDetails(courseId);
    } else {
      print('Error: Course ID is null. Cannot fetch course details.');
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Course ID missing.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> fetchCourseDetails(String courseId) async {
    isLoading.value = true;
    try {
      final fetchedCourse = await _courseRepository.getCourseById(courseId);
      if (fetchedCourse != null) {
        _course.value = fetchedCourse;
        print('Fetched course: ${fetchedCourse.title}');
        _initializeVideoPlayer(fetchedCourse.introVideoUrl);
        // Fetch lessons after course details are loaded
        if (fetchedCourse.lessonIds != null &&
            fetchedCourse.lessonIds!.isNotEmpty) {
          final fetchedLessons = await _lessonRepository.getLessonsByIds(
            fetchedCourse.lessonIds!,
          );
          _lessons.assignAll(fetchedLessons);
          print(
            'Fetched ${_lessons.length} lessons for course ${fetchedCourse.id}.',
          );
        } else {
          _lessons.clear();
          print('No lesson IDs found for course ${fetchedCourse.id}.');
        }
      }
    } catch (e) {
      print('Error fetching course details or lessons: $e');
      Get.snackbar(
        'Error',
        'Failed to load course details or lessons: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _initializeVideoPlayer(String? videoUrl) {
    if (videoUrl != null && videoUrl.isNotEmpty) {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      )
        ..initialize()
            .then((_) {
          isVideoInitialized.value = true;
          videoDuration.value = videoPlayerController.value.duration;
          videoPlayerController.addListener(_videoListener);
          videoPlayerController.setLooping(true);
          videoPlayerController.play();
          isPlaying.value = true;
        })
            .catchError((e) {
          print('Error initializing video player: $e');
          isVideoInitialized.value = false;
          Get.snackbar(
            'Video Error',
            'Could not load video: ${e.toString()}',
            snackPosition: SnackPosition.BOTTOM,
          );
        });
    } else {
      isVideoInitialized.value = false;
      print('No intro video URL provided.');
    }
  }

  void _videoListener() {
    if (videoPlayerController.value.isInitialized) {
      videoPosition.value = videoPlayerController.value.position;
      isPlaying.value = videoPlayerController.value.isPlaying;
    }
  }

  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    isPlaying.value = videoPlayerController.value.isPlaying;
  }

  void seekTo(Duration position) {
    videoPlayerController.seekTo(position);
  }

  void toggleControlsVisibility() {
    showControls.value = !showControls.value;
  }

  void nextStep() {
    if (currentStep.value < (lessons.length - 1)) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < lessons.length) {
      currentStep.value = step;
    }
  }

  @override
  void onClose() {
    if (videoPlayerController.value.isInitialized) {
      videoPlayerController.dispose();
    }
    super.onClose();
  }

  Future<void> _launchWhatsApp(String phoneNumber, String message) async {
    final cleanPhoneNumber = phoneNumber.replaceAll('+', '').replaceAll('', '');
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl =
        'whatsapp://send?phone=$cleanPhoneNumber&text=$encodedMessage';
    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        final webWhatsappUrl =
            "https://wa.me/$cleanPhoneNumber?text=$encodedMessage";
        if (await canLaunchUrl(Uri.parse(webWhatsappUrl))) {
          await launchUrl(Uri.parse(webWhatsappUrl));
        } else {
          Get.snackbar(
            'Error',
            'Could not open WhatsApp. Please ensure it is installed.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.errorColor,
            colorText: AppColors.hubWhite,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to launch WhatsApp: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.hubWhite,
      );
    }
  }

  void handleEnrollment(CourseModel course) {
    if (_authController.currentUser != null) {
      final String whatsappNumber = '971542412398';
      final String? userName =
          _authController.currentUser?.name ??
              _authController.currentUser?.email ??
              'User';
      final String whatsappMessage =
          "Hello, I'm interested in enrolling in the course: ${course.title}. My name is $userName. Course ID: ${course.id}";
      _launchWhatsApp(whatsappNumber, whatsappMessage);
    }
    else{
      Get.snackbar(
        'Login Required',
        'Please log in to enroll in this course.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.hubWhite,
      );
      Get.toNamed(Routes.AUTH);
    }
  }
}
