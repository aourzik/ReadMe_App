import 'package:flutter/material.dart';

enum BookCoverStyle { serif, modern, classic }

class Book {
  final String id;
  final String title;
  final String author;
  final List<Color> palette;
  final BookCoverStyle coverStyle;
  final double rating;
  final int year;
  final int pages;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.palette,
    required this.coverStyle,
    required this.rating,
    required this.year,
    required this.pages,
  });
}
