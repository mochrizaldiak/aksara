import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';

final bookListProvider = FutureProvider<List<Book>>((ref) async {
  final jsonStr = await rootBundle.loadString('assets/data/books.json');
  final data = json.decode(jsonStr);
  print(data);
  final books =
      (data['books'] as List)
          .map((bookJson) => Book.fromJson(bookJson))
          .toList();
  return books;
});
