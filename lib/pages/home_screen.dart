import 'package:book_tracker/components/grid_view_widget.dart';
import 'package:book_tracker/models/book.dart';
import 'package:book_tracker/network/network.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    Network network =Network();
    List<Book> _books=[];

  Future<void> _searchBook(String query) async
  {
    try {
      List<Book> books = await network.searchBook(query);
      setState(() {
        _books =books;
      });
      
    } catch (e) {
      print("Didn't get anything...");
    }

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  hint: Text("Search for a book",style: TextStyle(color: Colors.grey,)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onSubmitted:(value) => _searchBook(value),
            ),
            ),

            GridViewWidget(books: _books)
          ],
        ),
      ),
    );
  }
}