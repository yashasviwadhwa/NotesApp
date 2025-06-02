class Notes {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Notes({
    this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
    DateTime? createdAt,
  }) : createdAt = DateTime.now();

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id as String;
    }
    return map;
  }

  // String get formattedCreatedAt => DateFormat('yyyy-MM-dd').format(createdAt);
  // String get formattedUpdatedAt => DateFormat('yyyy-MM-dd').format(updatedAt);
}
