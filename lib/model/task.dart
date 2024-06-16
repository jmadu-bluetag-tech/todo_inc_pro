// class Task {
//   Task({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.isCompleted,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   final String id;
//   final String title;
//   final String description;
//   final bool isCompleted;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   factory Task.fromJson(Map<String, dynamic> json) {
//     return Task(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? 'Untitled',
//       description: json['description'] ?? 'No description',
//       isCompleted: json['is_completed'] ?? false,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "description": description,
//         "is_completed": isCompleted,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
class Task {
  Task({
    this.id = '',
    required this.title,
    required this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description',
      isCompleted: json['is_completed'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
