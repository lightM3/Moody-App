import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:moody/domain/models/room.dart';
import 'package:moody/domain/models/room_item.dart';
import 'package:moody/data/repositories/room_repository.dart';
import 'package:moody/domain/exceptions/room_exceptions.dart';

// Provides the repository
final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final supabase = Supabase.instance.client;
  return RoomRepository(supabase);
});

// Holds all room data
class RoomState {
  final Room room;
  final List<RoomItem> items;

  const RoomState({required this.room, required this.items});

  RoomState copyWith({Room? room, List<RoomItem>? items}) {
    return RoomState(room: room ?? this.room, items: items ?? this.items);
  }
}

// Main Notifier to handle business logic
class RoomNotifier extends AsyncNotifier<RoomState> {
  late RoomRepository _repository;

  @override
  Future<RoomState> build() async {
    _repository = ref.read(roomRepositoryProvider);

    // Auth state'den userId al.
    // TODO: Kullanıcı ID'sini uygulamanın auth provider'ından almak daha doğru olur, şimdilik Supabase auth kullanılıyor.
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      throw const UnauthorizedRoomAccessException();
    }

    return _fetchRoomData(currentUser.id);
  }

  Future<RoomState> _fetchRoomData(String userId) async {
    try {
      final room = await _repository.fetchUserRoom(userId);
      final items = await _repository.fetchRoomItems(room.id);

      return RoomState(room: room, items: items);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshRoom() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) {
        throw const UnauthorizedRoomAccessException();
      }
      return _fetchRoomData(currentUser.id);
    });
  }

  Future<void> updateItemPosition(String itemId, double x, double y) async {
    final currentState = state.value;
    if (currentState == null) return;

    // Optimistik UI Güncellemesi
    try {
      // 1. Önce UI'ı hemen güncelle (Kullanıcı beklemez)
      final updatedItems = currentState.items.map((item) {
        if (item.id == itemId) {
          return item.copyWith(xPosition: x, yPosition: y);
        }
        return item;
      }).toList();

      state = AsyncValue.data(currentState.copyWith(items: updatedItems));

      // 2. Arka planda Supabase'e yaz
      await _repository.updateItemPosition(itemId, x, y);
    } catch (e) {
      // Hata olursa UI'ı eski state'e çevir, sonra exception'ı yukarı fırlat
      state = AsyncValue.data(currentState);
      throw RoomUpdateException(
        'Pozisyon güncellenemedi, değişiklik geri alındı.',
        originalError: e,
      );
    }
  }
}

// Global Provider
final roomProvider = AsyncNotifierProvider<RoomNotifier, RoomState>(() {
  return RoomNotifier();
});
