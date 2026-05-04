import 'package:flutter/material.dart';

class Friend {
  final String id;
  final String name;
  final String handle;
  final String initials;
  final Color tone;
  final int books;
  final int mutual;

  const Friend({
    required this.id,
    required this.name,
    required this.handle,
    required this.initials,
    required this.tone,
    required this.books,
    required this.mutual,
  });
}

class SuggestedFriend {
  final String id;
  final String name;
  final String handle;
  final String initials;
  final Color tone;
  final int mutual;

  const SuggestedFriend({
    required this.id,
    required this.name,
    required this.handle,
    required this.initials,
    required this.tone,
    required this.mutual,
  });
}

class CurrentUser {
  final String id;
  final String name;
  final String handle;
  final String initials;
  final Color tone;
  final int books;
  final int friends;
  final int reviews;

  const CurrentUser({
    required this.id,
    required this.name,
    required this.handle,
    required this.initials,
    required this.tone,
    required this.books,
    required this.friends,
    required this.reviews,
  });
}
