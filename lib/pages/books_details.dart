import 'package:book_tracker/utils/book_details_arguments.dart';
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

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(bookData.bookItem.imageLinks.isNotEmpty)
               Padding(
                  padding: const EdgeInsets.only(
                    top:15,
                    left: 10,
                    right: 10,
                    bottom: 10
                    ),
                  child: Image.network(bookData.bookItem.imageLinks['thumbnail']?? '',fit:BoxFit.contain,height: 180,),
                ),
              
              Text(bookData.bookItem.title,style:theme.textTheme.titleMedium,),
              Text(bookData.bookItem.authors.join(', '),style: theme.textTheme.bodySmall,),
              Text("Published: ${bookData.bookItem.publishedDate}",style: theme.textTheme.bodySmall,),
              Text("Page Count: ${bookData.bookItem.pageCount}",style: theme.textTheme.bodySmall,),
              Text("Language: ${bookData.bookItem.language}",style: theme.textTheme.bodySmall,),
              Row(
                children: [
                  
                ],
              )

            ],
          
          ),
        ),
      ),
    );
  }
}