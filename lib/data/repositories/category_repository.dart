import 'package:shabakahub2025/data/models/category_model.dart';
import 'package:shabakahub2025/data/providers/category_provider.dart';

class CategoryRepository {
  final CategoryProvider _categoryProvider;

  CategoryRepository(
      this._categoryProvider); // The repository depends on the provider

// Method to fetch a list of all Categories
// This method will call the provider to get the data
Future<List<CategoryModel>> getAllCategories()async
{
  try{
    return await _categoryProvider.getCategoryList();
  }
      catch(e)
      {
        throw Exception('Failed to fetch categories from repository: ${e.toString()}');
      }
}
}
