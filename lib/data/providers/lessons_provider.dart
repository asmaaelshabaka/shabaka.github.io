import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shabakahub2025/data/models/lesson_model.dart';
import 'package:shabakahub2025/utils/app_environment.dart';

class LessonProvider
{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
// Method to fetch a list of lessons by their IDs
Future<List<LessonModel>> getLessonsByIds(List<String> lessonIds)async
{
if(lessonIds.isEmpty){return [];}
try{
  final appId=AppEnvironment.appId ?? 'default-app-id';
  final lessonsCollectionRef=_firestore.collection('artifacts').doc(appId).collection('public').doc('data').collection('lessons');
  final querySnapshot=await lessonsCollectionRef.where(FieldPath.documentId,whereIn: lessonIds).get();
  final fetchedLessons=querySnapshot.docs.map((doc){return LessonModel.fromMap(doc.data());}).toList();
  fetchedLessons.sort((a,b)=>a.order.compareTo(b.order));
  return fetchedLessons;
}
catch (e){print('LessonProvider: Error loading lessons from Firestore: $e');
throw Exception('Failed to load lessons from Firestore.');}
}
}