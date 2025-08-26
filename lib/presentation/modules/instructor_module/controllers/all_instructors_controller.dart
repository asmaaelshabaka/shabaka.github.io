import 'package:get/get.dart';
import 'package:shabakahub2025/data/models/instructor_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../data/repositories/instructor_repository.dart';

class InstructorController extends GetxController {
  static InstructorController get to => Get.find();
  final InstructorRepository _instructorRepository = InstructorRepository();

  // Reactive state
  var instructors = <InstructorModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void onInit() {
    super.onInit();
    fetchInstructors();
  }

  Future<void> fetchInstructors() async {
    try {
      isLoading(true);
      final fetchedInstructors = await _instructorRepository.getAllInstructors();

      // Process images for all instructors
      final updatedInstructors = await Future.wait(
        fetchedInstructors.map((instructor) async {
          if (instructor.profilePicturePath != null) {  // Changed from profilePictureUrl
            final url = await _getImageUrl(instructor.profilePicturePath!);
            return instructor.copyWith(profilePictureUrl: url);  // Use copyWith
          }
          return instructor;
        }),
      );

      instructors.assignAll(updatedInstructors);
      errorMessage('');
    } catch (e) {
      print('InstructorController: Error fetching instructors: $e');
      errorMessage('Failed to load instructors. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  Future<String> _getImageUrl(String storagePath) async {
    try {
      return await _storage.ref(storagePath).getDownloadURL();
    } catch (e) {
      print('Error getting image URL: $e');
      return ''; // Return empty string or a placeholder image URL
    }
  }

  InstructorModel? getInstructorById(String instructorId) {
    return instructors.firstWhereOrNull(
          (instructor) => instructor.id == instructorId,
    );
  }
}