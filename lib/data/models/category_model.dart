// lib/data/models/category_model.dart
class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
  });

  // Factory constructor to create a CategoryModel from a Map (e.g., from Firestore)
  // Renamed from fromJson to fromMap for clarity with Firestore's Map<String, dynamic>
  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'] as String,
      name: data['name'] as String,
      description: data['description'] as String?, // Handle as nullable String
      imageUrl: data['imageUrl'] as String?,     // Handle as nullable String
    );
  }

  // Method to convert CategoryModel to a Map (for uploading to Firestore)
  // Renamed from toJson to toMap for clarity with Firestore's Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name)';
  }
}
