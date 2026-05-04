enum FeedItemKind { review, added, borrow }

class FeedItem {
  final String id;
  final FeedItemKind kind;
  final String friendId;
  final String bookId;
  final double? rating;
  final String? text;
  final String? shelf;
  final String? fromId;
  final String time;

  const FeedItem({
    required this.id,
    required this.kind,
    required this.friendId,
    required this.bookId,
    this.rating,
    this.text,
    this.shelf,
    this.fromId,
    required this.time,
  });
}

class UserReview {
  final String bookId;
  final double rating;
  final String text;

  const UserReview({
    required this.bookId,
    required this.rating,
    required this.text,
  });
}

class FriendRequest {
  final String fromId;
  final int mutual;

  const FriendRequest({required this.fromId, required this.mutual});
}
