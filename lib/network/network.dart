import 'package:book_tracker/models/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{

  //Api endpoint
  static const String _baseURL =
  'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> searchBook(String query) async
  {
    var url = Uri.parse('$_baseURL?q=$query');
    var response = await http.get(url);

    if(response.statusCode == 200)  {
      //we have data (Json)
      var data = json.decode(response.body);
      if(data['items'] != null && data['items'] is List){
       List<Book> books =
      (data['items'] as List<dynamic>).map((book)=>
      Book.fromJson(book as Map<String,dynamic>)).toList();

      return books;
    }
    else{
      return [];
    }

  }
  else
  {
    throw Exception('Failed to load');
  }
  }


}