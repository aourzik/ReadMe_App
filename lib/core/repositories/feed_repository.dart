import '../services/supabase_service.dart';

class FeedRepository {
  final _db = SupabaseService.client;

  // Fil d'activité des amis (temps réel)
  Stream<List<Map<String, dynamic>>> watchFeed() {
    return _db
        .from('user_books')
        .stream(primaryKey: ['id'])
        .order('added_at', ascending: false)
        .limit(50)
        .map((rows) => rows);
  }

  // Demander à emprunter un livre
  Future<void> requestBorrow({
    required String ownerId,
    required String bookId,
    required String message,
  }) async {
    await _db.from('borrow_requests').insert({
      'requester_id': SupabaseService.currentUser!.id,
      'owner_id':     ownerId,
      'book_id':      bookId,
      'message':      message,
    });
  }
}