class InstructorModel {
  final String id;
  final String name;
  final String bio;
  late final String? profilePictureUrl; // Changed from late final to final
  final String? profilePicturePath; // New field for storage path
  final List<String> courseIds;

  InstructorModel({
    required this.id,
    required this.name,
    required this.bio,
    this.profilePictureUrl,
    this.profilePicturePath, // Added new parameter
    this.courseIds = const [],
  });

  factory InstructorModel.fromMap(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      bio: json['bio'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      profilePicturePath: json['profilePicturePath'] as String?, // Added
      courseIds: List<String>.from(json['courseIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'profilePicturePath': profilePicturePath, // Added
      'courseIds': courseIds,
    };
  }

  InstructorModel copyWith({
    String? id,
    String? name,
    String? bio,
    String? profilePictureUrl,
    String? profilePicturePath, // Added
    List<String>? courseIds,
  }) {
    return InstructorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath, // Added
      courseIds: courseIds ?? this.courseIds,
    );
  }

  @override
  String toString() {
    return 'InstructorModel(id: $id, name: $name, hasImage: ${profilePictureUrl != null || profilePicturePath != null})';
  }
}