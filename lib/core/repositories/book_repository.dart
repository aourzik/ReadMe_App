import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/book.dart';
import '../services/supabase_service.dart';

class BookRepository {
  final _db = SupabaseService.client;

  // Tous les livres de l'utilisateur
  Future<List<Map<String, dynamic>>> getMyBooks() async {
    return await _db
        .from('user_books')
        .select('*, books(*)')
        .eq('user_id', SupabaseService.currentUser!.id)
        .order('added_at', ascending: false);
  }

  // Ajouter un livre à ma bibliothèque
  Future<void> addBook({
    required String bookId,
    required String shelf,
    double? rating,
    String? review,
  }) async {
    await _db.from('user_books').upsert({
      'user_id': SupabaseService.currentUser!.id,
      'book_id': bookId,
      'shelf':   shelf,
      'rating':  rating,
      'review':  review,
    });
  }

  // Mettre à jour la progression
  Future<void> updateProgress(String bookId, int pages) async {
    await _db
        .from('user_books')
        .update({'progress': pages})
        .eq('user_id', SupabaseService.currentUser!.id)
        .eq('book_id', bookId);
  }

  // Chercher un livre dans le catalogue
  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    return await _db
        .from('books')
        .select()
        .ilike('title', '%$query%')
        .limit(20);
  }
}