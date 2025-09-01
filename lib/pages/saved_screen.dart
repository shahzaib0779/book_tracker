import 'package:book_tracker/db/database_helper.dart';
import 'package:book_tracker/models/book.dart';
import 'package:book_tracker/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Books"),
        backgroundColor:theme.colorScheme.inversePrimary ,
      ),

      body: FutureBuilder(future: DatabaseHelper.instance.readAllBook(),
      builder: (context,snapshot)=> snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (context,index){
          Book book = snapshot.data![index];
        return InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/details',arguments: BookDetailsArguments(bookItem: book,isFromSaved: true));
          },
          child: Card(
            child: ListTile(title: Text(book.title),
            trailing: IconButton(icon:Icon(Icons.delete), onPressed: ()async {
              await DatabaseHelper.instance.deleteBook(book.id);
              SnackBar snackBar =SnackBar(content: Text("Book Deleted!"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              setState(() {});
              },),
            leading: Image.network(book.imageLinks['thumbnail']??'',fit: BoxFit.cover,),
            shape: Border.all(color: theme.colorScheme.primary),
            subtitle: Column(
              children: [
                Text(book.authors.join(', ')),
                ElevatedButton.icon(onPressed:() async{
                 await DatabaseHelper.instance.toggleFavorite(book.id, !book.isFavorite);
                  
                }, 
                label:Text("Add to favorites"),
                icon: Icon(Icons.favorite),)
          
              ],
            ),
            ),
            
          ),
        );
      })
      :Center(child: CircularProgressIndicator())),


    );
  }
}