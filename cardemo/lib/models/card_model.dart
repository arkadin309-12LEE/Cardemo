class CardModel {
  final int? id;
  final String title;
  final String content;
  final String? frontImage;
  final int? deckId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CardModel({
    this.id,
    required this.title,
    required this.content,
    this.frontImage,
    this.deckId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'front_image': frontImage,
      'deck_id': deckId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      frontImage: map['front_image'] as String?,
      deckId: map['deck_id'] as int?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  CardModel copyWith({
    int? id,
    String? title,
    String? content,
    String? frontImage,
    int? deckId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      frontImage: frontImage ?? this.frontImage,
      deckId: deckId ?? this.deckId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
