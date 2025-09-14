import 'package:book_tracker/models/book.dart';
import 'package:book_tracker/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
      itemCount: _books.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.56),
      itemBuilder: (context,index){
        Book book =_books[index];
         var theme = Theme.of(context);
         return Container(
          margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/details',arguments: BookDetailsArguments(bookItem: book,isFromSaved: false));
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
                child: Image.network(book.imageLinks['thumbnail']?? '',fit:BoxFit.contain,scale: 1.2,),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  child: Text(book.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: theme.textTheme.titleMedium?.copyWith(fontFamily: 'Montserrat'),),
                ),
              ),
          
              SizedBox(
                child: Text(book.authors.join(', '),overflow:TextOverflow.ellipsis,maxLines: 1
                ,style : theme.textTheme.bodyLarge?.copyWith(fontFamily: 'Montserrat'),),
              ),
            ],
          ),
        ),
        );
      }),
    );
  }
}