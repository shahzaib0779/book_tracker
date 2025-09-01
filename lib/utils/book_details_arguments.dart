import 'package:book_tracker/models/book.dart';

class BookDetailsArguments {
  final Book bookItem;
  final bool isFromSaved;

  BookDetailsArguments({required this.isFromSaved, required this.bookItem});
}