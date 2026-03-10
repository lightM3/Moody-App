abstract class RoomException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const RoomException(this.message, {this.code, this.originalError});

  @override
  String toString() {
    if (code != null) return 'RoomException[$code]: $message';
    return 'RoomException: $message';
  }
}

class RoomNotFoundException extends RoomException {
  const RoomNotFoundException({super.originalError})
    : super(
        'Oda bulunamadı. Lütfen daha sonra tekrar deneyin.',
        code: 'ROOM_NOT_FOUND',
      );
}

class RoomFetchException extends RoomException {
  const RoomFetchException(String message, {super.originalError})
    : super(message, code: 'ROOM_FETCH_ERROR');
}

class RoomUpdateException extends RoomException {
  const RoomUpdateException(String message, {super.originalError})
    : super(message, code: 'ROOM_UPDATE_ERROR');
}

class UnauthorizedRoomAccessException extends RoomException {
  const UnauthorizedRoomAccessException({super.originalError})
    : super('Bu odayı düzenleme yetkiniz yok.', code: 'UNAUTHORIZED_ACCESS');
}
