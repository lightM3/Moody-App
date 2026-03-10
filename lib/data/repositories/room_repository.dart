import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:moody/domain/models/room.dart';
import 'package:moody/domain/models/room_item.dart';
import 'package:moody/domain/exceptions/room_exceptions.dart';

class RoomRepository {
  final SupabaseClient _supabase;

  RoomRepository(this._supabase);

  Future<Room> fetchUserRoom(String userId) async {
    try {
      final response = await _supabase
          .from('rooms')
          .select('*, profiles(*)')
          .eq('owner_id', userId)
          .single();

      return Room.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw RoomNotFoundException(originalError: e);
      }
      throw RoomFetchException(
        'Oda bilgileri getirilirken veritabanı hatası oluştu.',
        originalError: e,
      );
    } catch (e) {
      throw RoomFetchException(
        'Oda bilgileri getirilemedi. Lütfen bağlantınızı kontrol edin.',
        originalError: e,
      );
    }
  }

  Future<List<RoomItem>> fetchRoomItems(String roomId) async {
    try {
      final response = await _supabase
          .from('room_items')
          .select()
          .eq('room_id', roomId)
          .order('z_index', ascending: true);

      return (response as List).map((json) => RoomItem.fromJson(json)).toList();
    } catch (e) {
      throw RoomFetchException('Oda eşyaları getirilemedi.', originalError: e);
    }
  }

  Future<void> updateItemPosition(String itemId, double x, double y) async {
    try {
      await _supabase
          .from('room_items')
          .update({
            'x_position': x,
            'y_position': y,
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id', itemId);
    } on PostgrestException catch (e) {
      throw RoomUpdateException(
        'Eşya pozisyonu güncellenirken veritabanı hatası oluştu.',
        originalError: e,
      );
    } catch (e) {
      throw RoomUpdateException(
        'Eşya pozisyonu internet bağlantısı nedeniyle güncellenemedi.',
        originalError: e,
      );
    }
  }
}
