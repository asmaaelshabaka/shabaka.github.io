// lib/modules/course_module/providers/category_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shabakahub2025/data/models/category_model.dart';
import 'package:shabakahub2025/utils/app_environment.dart'; // Import AppEnvironment

class CategoryProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategoryList() async {
    try {
      // CRUCIAL FIX: Ensure appId is never null by providing a fallback
      final appId = AppEnvironment.appId ?? 'default-app-id';

      // Correctly reference the categories collection
      final collectionPath = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('categories');

      final querySnapshot = await collectionPath.get();

      // Use CategoryModel.fromMap to convert Firestore data
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error loading categories from Firestore: $e');
      throw Exception('Failed to load categories from Firestore.');
    }
  }
}
