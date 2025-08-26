import 'package:shabakahub2025/data/models/instructor_model.dart';

import '../providers/instructor_provider.dart';

class InstructorRepository {
  final InstructorProvider _instructorProvider = InstructorProvider();
  Future<List<InstructorModel>> getAllInstructors() async {
    try {
      return await _instructorProvider.getAllInstructors();
    } catch (e) {
      print('InstructorRepository: Error getting all instructors: $e');
      rethrow;
    }
  }



 Future<InstructorModel?> getInstructorById(String instructorId)async
  {try
  {
    return await _instructorProvider.getInstructorById(instructorId);
  }
      catch(e)
    {
      print('InstructorRepository: Error getting instructor with ID $instructorId: $e');
      rethrow;

    }

  }
}
