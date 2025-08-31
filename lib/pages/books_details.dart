import 'package:book_tracker/pages/home_screen.dart';
import 'package:flutter/material.dart';

class BooksDetails extends StatefulWidget {
  const BooksDetails({super.key});

  @override
  State<BooksDetails> createState() => _BooksDetailsState();
}

class _BooksDetailsState extends State<BooksDetails> {
  @override
  Widget build(BuildContext context) {
   final bookData= ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bookData.bookItem.title),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
    );
  }
}