import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'package:shabakahub2025/data/models/course_model.dart';

import '../../utils/app_environment.dart';

class CourseProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Method to fetch all courses (optional, but good to have)

  Future<List<CourseModel>> getAllCourses() async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final coursesRef = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('courses');
      final querySnapshot = await coursesRef.get();
      return querySnapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error loading all courses from Firestore: $e');
      throw Exception('Failed to load all courses from Firestore.');
    }
  }

  // Method to fetch courses by a specific category ID

  Future<List<CourseModel>> getCoursesByCategoryId(String categoryId) async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final coursesRef = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('courses');
      final querySnapshot =
          await coursesRef.where('categoryId', isEqualTo: categoryId).get();
      return querySnapshot.docs
          .map((doc) => CourseModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print(
        'Error loading courses by category ID $categoryId from Firestore: $e',
      );
      throw Exception(
        'Failed to load courses for category $categoryId from Firestore.',
      );
    }
  }


  Future<CourseModel?> getCourseById(String courseId) async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final courseDocRef = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('courses')
          .doc(courseId); // Reference to the specific course document

      final docSnapshot = await courseDocRef.get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return CourseModel.fromMap(docSnapshot.data()!);
      } else {
        print('Course with ID $courseId not found in Firestore.');
        return null;
      }
    } catch (e) {
      print('Error loading course with ID $courseId from Firestore: $e');
      throw Exception('Failed to load course details from Firestore.');
    }
  }





}
