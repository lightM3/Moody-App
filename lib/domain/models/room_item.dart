class RoomItem {
  final String id;
  final String roomId;
  final String itemType;
  final double xPosition;
  final double yPosition;
  final int zIndex;
  final Map<String, dynamic> metadata;
  final DateTime updatedAt;

  const RoomItem({
    required this.id,
    required this.roomId,
    required this.itemType,
    required this.xPosition,
    required this.yPosition,
    required this.zIndex,
    required this.metadata,
    required this.updatedAt,
  });

  factory RoomItem.fromJson(Map<String, dynamic> json) {
    return RoomItem(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      itemType: json['item_type'] as String,
      xPosition: (json['x_position'] as num).toDouble(),
      yPosition: (json['y_position'] as num).toDouble(),
      zIndex: json['z_index'] as int,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'item_type': itemType,
      'x_position': xPosition,
      'y_position': yPosition,
      'z_index': zIndex,
      'metadata': metadata,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  RoomItem copyWith({
    String? id,
    String? roomId,
    String? itemType,
    double? xPosition,
    double? yPosition,
    int? zIndex,
    Map<String, dynamic>? metadata,
    DateTime? updatedAt,
  }) {
    return RoomItem(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      itemType: itemType ?? this.itemType,
      xPosition: xPosition ?? this.xPosition,
      yPosition: yPosition ?? this.yPosition,
      zIndex: zIndex ?? this.zIndex,
      metadata: metadata ?? this.metadata,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
