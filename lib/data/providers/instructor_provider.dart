import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shabakahub2025/utils/app_environment.dart';

import '../models/instructor_model.dart';

class  InstructorProvider{
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Method to fetch all instructors
  Future<List<InstructorModel>> getAllInstructors() async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final instructorsCollectionRef = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('instructors');
      final querySnapshot = await instructorsCollectionRef.get();
      return querySnapshot.docs.map((doc) {
        return InstructorModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      print(
        'InstructorProvider: Error loading all instructors from Firestore: $e',
      );
      throw Exception('Failed to load instructors from Firestore.');
    }
  }

  Future<InstructorModel?> getInstructorById(String instructorId) async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final instructorDocRef = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('instructors')
          .doc(instructorId);
      final docSnapshot = await instructorDocRef.get();
      if (docSnapshot.data() != null && docSnapshot.exists) {
        return InstructorModel.fromMap(docSnapshot.data()!);
      } else {
        print('Instructor with ID $instructorId not found in Firestore.');
        return null;
      }
    } catch (e) {
      print(
        'InstructorProvider: Error loading instructor with ID $instructorId from Firestore: $e',
      );
      throw Exception('Failed to load instructor details from Firestore.');
    }
  }
}
