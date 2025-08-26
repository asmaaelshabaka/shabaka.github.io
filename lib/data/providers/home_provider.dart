import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/app_environment.dart';

class HomeProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getIntroVideo() async {
    try {
      final appId = AppEnvironment.appId ?? 'default-app-id';
      final homeContentRef = _firestore
          .collection('artifacts')
          .doc(appId)
          .collection('public')
          .doc('data')
          .collection('home_content')
          .doc('intro_video');
      final docSnapshot = await homeContentRef.get();
      if (docSnapshot.data() != null && docSnapshot.exists) {
        return docSnapshot.data()?['intro_video'] as String;
      }
    } catch (e) {
      print('Error loading intro video URL: $e');
      return null;
    }
  }
}
