import '../services/supabase_service.dart';

class FriendshipRepository {
  final _db = SupabaseService.client;

  // Mes amis acceptés
  Future<List<Map<String, dynamic>>> getFriends() async {
    final uid = SupabaseService.currentUser!.id;
    return await _db
        .from('friendships')
        .select('*, requester:profiles!requester_id(*), addressee:profiles!addressee_id(*)')
        .eq('status', 'accepted')
        .or('requester_id.eq.$uid,addressee_id.eq.$uid');
  }

  // Demandes reçues en attente
  Future<List<Map<String, dynamic>>> getPendingRequests() async {
    return await _db
        .from('friendships')
        .select('*, requester:profiles!requester_id(*)')
        .eq('addressee_id', SupabaseService.currentUser!.id)
        .eq('status', 'pending');
  }

  // Envoyer une demande d'ami
  Future<void> sendRequest(String friendId) async {
    await _db.from('friendships').insert({
      'requester_id': SupabaseService.currentUser!.id,
      'addressee_id': friendId,
    });
  }

  // Accepter / refuser
  Future<void> respond(String friendshipId, bool accept) async {
    await _db
        .from('friendships')
        .update({'status': accept ? 'accepted' : 'rejected'})
        .eq('id', friendshipId);
  }
}