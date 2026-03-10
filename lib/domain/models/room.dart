import 'package:moody/domain/models/profile.dart';

class Room {
  final String id;
  final String ownerId;
  final String moodTitle;
  final String themeColor;
  final bool isPrivate;
  final DateTime createdAt;

  // Joins (eğer fetch edilirse dolu gelir)
  final Profile? ownerProfile;

  const Room({
    required this.id,
    required this.ownerId,
    required this.moodTitle,
    required this.themeColor,
    required this.isPrivate,
    required this.createdAt,
    this.ownerProfile,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      moodTitle: json['mood_title'] as String,
      themeColor: json['theme_color'] as String,
      isPrivate: json['is_private'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      ownerProfile: json['profiles'] != null
          ? Profile.fromJson(json['profiles'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'owner_id': ownerId,
      'mood_title': moodTitle,
      'theme_color': themeColor,
      'is_private': isPrivate,
      'created_at': createdAt.toIso8601String(),
    };
    if (ownerProfile != null) {
      data['profiles'] = ownerProfile!.toJson();
    }
    return data;
  }

  Room copyWith({
    String? id,
    String? ownerId,
    String? moodTitle,
    String? themeColor,
    bool? isPrivate,
    DateTime? createdAt,
    Profile? ownerProfile,
  }) {
    return Room(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      moodTitle: moodTitle ?? this.moodTitle,
      themeColor: themeColor ?? this.themeColor,
      isPrivate: isPrivate ?? this.isPrivate,
      createdAt: createdAt ?? this.createdAt,
      ownerProfile: ownerProfile ?? this.ownerProfile,
    );
  }
}
