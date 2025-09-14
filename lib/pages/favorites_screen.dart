import 'package:book_tracker/db/database_helper.dart';
import 'package:book_tracker/models/book.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Books",style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w600),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Icon(Icons.favorite),
      ),

      body: FutureBuilder(future: DatabaseHelper.instance.getFavorite(),
      builder:(context,snapshot){
        if(snapshot.connectionState ==ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError) {
          return Center(child: Text("Error ${snapshot.error}"),);

        }
        else if(snapshot.hasData && snapshot.data!.isNotEmpty)
        {
          List<Book> favBooks = snapshot.data!;

          return ListView.builder(
            itemCount:favBooks.length ,
            itemBuilder: (context,index){
            Book fav = favBooks[index];

            var textStyle = TextStyle(fontFamily: 'Montserrat');
            return Card(
              child: ListTile(
              leading: Image.network(fav.imageLinks['thumbnail']??'',fit: BoxFit.cover,),
              title: Text(fav.title,style: textStyle,),
              subtitle: Text(fav.authors.join(', '),style: textStyle,),
              trailing: Icon(Icons.favorite,color: Colors.red,),
            )

            
            );
          });
        }
        return Center(child: Text("No Favorite Book Found",style: TextStyle(fontFamily: 'Montserrat'),));
       
       }
       ),
    );
  }
}