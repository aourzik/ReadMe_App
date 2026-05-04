import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/friend.dart';
import '../models/feed_item.dart';

const kCreem = Color(0xFFFCFEEC);
const kGreen = Color(0xFF062A04);
const kGold = Color(0xFF9A8B0A);
const kBlack = Color(0xFF242321);

final List<Book> kBooks = [
  const Book(id: 'b1', title: 'The Salt Path', author: 'Rae Lourdes', palette: [Color(0xFF0E330A), Color(0xFFF6FADD)], coverStyle: BookCoverStyle.serif, rating: 4.5, year: 2023, pages: 312),
  const Book(id: 'b2', title: 'Pale Constellations', author: 'M. Henrik', palette: [Color(0xFF9A8B0A), Color(0xFF242321)], coverStyle: BookCoverStyle.modern, rating: 4.2, year: 2022, pages: 244),
  const Book(id: 'b3', title: 'A Quiet Architecture', author: 'Ines Vidal', palette: [Color(0xFFF6FADD), Color(0xFF0E330A)], coverStyle: BookCoverStyle.classic, rating: 4.8, year: 2021, pages: 408),
  const Book(id: 'b4', title: 'Ferns & Iron', author: 'Cole Aster', palette: [Color(0xFF242321), Color(0xFF9A8B0A)], coverStyle: BookCoverStyle.serif, rating: 4.1, year: 2024, pages: 196),
  const Book(id: 'b5', title: 'House of Hours', author: 'Tomás Bea', palette: [Color(0xFF5e7355), Color(0xFFF6FADD)], coverStyle: BookCoverStyle.modern, rating: 4.6, year: 2020, pages: 352),
  const Book(id: 'b6', title: 'River Letters', author: 'Yara Sandoval', palette: [Color(0xFFF6FADD), Color(0xFF9A8B0A)], coverStyle: BookCoverStyle.classic, rating: 4.3, year: 2023, pages: 288),
  const Book(id: 'b7', title: 'On Returning', author: 'Petra Kohl', palette: [Color(0xFF0E330A), Color(0xFF9A8B0A)], coverStyle: BookCoverStyle.serif, rating: 4.7, year: 2019, pages: 224),
  const Book(id: 'b8', title: 'The Slow Hour', author: 'A. Mendel', palette: [Color(0xFF9A8B0A), Color(0xFFF6FADD)], coverStyle: BookCoverStyle.modern, rating: 3.9, year: 2024, pages: 176),
  const Book(id: 'b9', title: 'Granite Sky', author: 'Liv Sørensen', palette: [Color(0xFF242321), Color(0xFFF6FADD)], coverStyle: BookCoverStyle.classic, rating: 4.4, year: 2022, pages: 332),
];

final List<Friend> kFriends = [
  const Friend(id: 'f1', name: 'Camille Roux', handle: '@camille', initials: 'CR', tone: Color(0xFF0E330A), books: 47, mutual: 12),
  const Friend(id: 'f2', name: 'August Park', handle: '@august', initials: 'AP', tone: Color(0xFF9A8B0A), books: 122, mutual: 9),
  const Friend(id: 'f3', name: 'Iris Halevi', handle: '@iris', initials: 'IH', tone: Color(0xFF5e7355), books: 31, mutual: 4),
  const Friend(id: 'f4', name: 'Mateo Salinas', handle: '@mateo', initials: 'MS', tone: Color(0xFF242321), books: 88, mutual: 7),
  const Friend(id: 'f5', name: 'Noor Abadi', handle: '@noor', initials: 'NA', tone: Color(0xFF0E330A), books: 56, mutual: 11),
  const Friend(id: 'f6', name: 'Sasha Lindgren', handle: '@sasha', initials: 'SL', tone: Color(0xFF9A8B0A), books: 73, mutual: 3),
];

const kMe = CurrentUser(
  id: 'me', name: 'Eleanor Vance', handle: '@eleanor',
  initials: 'EV', tone: Color(0xFF0E330A),
  books: 64, friends: 28, reviews: 41,
);

final List<FeedItem> kFeed = [
  const FeedItem(id: 'a1', kind: FeedItemKind.review, friendId: 'f1', bookId: 'b3', rating: 5,
    text: 'A patient, almost monastic novel. Vidal builds rooms you don\'t want to leave — every chapter is a doorway.', time: '2h'),
  const FeedItem(id: 'a2', kind: FeedItemKind.added, friendId: 'f2', bookId: 'b5', shelf: 'Currently reading', time: '5h'),
  const FeedItem(id: 'a3', kind: FeedItemKind.review, friendId: 'f3', bookId: 'b1', rating: 4,
    text: 'Walked the coast with this one in my bag. It earns its quiet ending.', time: '1d'),
  const FeedItem(id: 'a4', kind: FeedItemKind.borrow, friendId: 'f4', bookId: 'b7', fromId: 'f1', time: '1d'),
  const FeedItem(id: 'a5', kind: FeedItemKind.review, friendId: 'f5', bookId: 'b2', rating: 4,
    text: 'Henrik\'s sentences cool the room. Half a star off for an indulgent middle.', time: '2d'),
];

final List<UserReview> kMyReviews = [
  const UserReview(bookId: 'b3', rating: 5, text: 'The quietest book I read this year. I underlined more than I should have.'),
  const UserReview(bookId: 'b1', rating: 4, text: 'Sat with me for weeks after. Lourdes writes weather like it has motive.'),
  const UserReview(bookId: 'b7', rating: 5, text: 'Read it on a train in October — perfect conditions for a perfect book.'),
];

final List<FriendRequest> kRequests = [
  const FriendRequest(fromId: 'f6', mutual: 3),
  const FriendRequest(fromId: 'f3', mutual: 4),
];

final List<SuggestedFriend> kSuggested = [
  const SuggestedFriend(id: 's1', name: 'Dario Lenz', handle: '@dario', initials: 'DL', tone: Color(0xFF5e7355), mutual: 6),
  const SuggestedFriend(id: 's2', name: 'Hana Pollard', handle: '@hana', initials: 'HP', tone: Color(0xFF9A8B0A), mutual: 4),
  const SuggestedFriend(id: 's3', name: 'Ren Aoyama', handle: '@ren', initials: 'RA', tone: Color(0xFF0E330A), mutual: 2),
];

Book? findBook(String id) => kBooks.where((b) => b.id == id).firstOrNull;
Friend? findFriend(String id) => kFriends.where((f) => f.id == id).firstOrNull;
