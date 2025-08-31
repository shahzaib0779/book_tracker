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

            Expanded(
              child: GridView.builder(
              itemCount: _books.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6),
              itemBuilder: (context,index){
                Book book =_books[index];
                 return Container(
                  margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/details',arguments: BookDetailsArguments(bookItem: book));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top:15,
                          left: 10,
                          right: 10,
                          bottom: 10
                        ),
                        child: Image.network(book.imageLinks['thumbnail']?? '',fit:BoxFit.contain,height: 180,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          child: Text(book.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleMedium,),
                        ),
                      ),
                  
                      SizedBox(
                        child: Text(book.authors.join(', '),overflow:TextOverflow.ellipsis,maxLines: 1
                        ,style : Theme.of(context).textTheme.bodyLarge,),
                      )
                  
                    ],
                  ),
                ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class BookDetailsArguments {
  final Book bookItem;

  BookDetailsArguments({required this.bookItem});
}