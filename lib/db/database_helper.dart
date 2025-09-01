import 'package:book_tracker/models/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static const _databaseName = 'books_database.db';
  static const _databaseVersion = 2;
  static const _tableName ='books';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get getDatabase async{
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async{

    String path =join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,version: _databaseVersion,onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{

    await db.execute('''
     CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      authors TEXT NOT NULL,
      favorite INTEGER DEFAULT 0,
      publisher TEXT,
      publishedDate TEXT,
      description TEXT,
      industryIdentifiers TEXT,
      pageCount INTEGER,
      language TEXT,
      imageLinks TEXT,
      previewLinks TEXT,
      infoLink TEXT
     )''');
  }

  Future<int> insert(Book book) async{
    Database db = await instance.getDatabase;
    return db.insert(_tableName, book.toJson()); 
  }

  Future<List<Book>> readAllBook() async{
    Database db = await instance.getDatabase;
    var books = await db.query(_tableName);
    return books.isNotEmpty ? books.map((bookData) =>Book.fromJsonDatabase(bookData)).toList():[];
  }

  Future<int> toggleFavorite (String id,bool isFavorite) async {
    Database db =await instance.getDatabase;

    return await db.update(_tableName, {
      'favorite':!isFavorite? 1: 0
    },
    where: 'id = ?',
    whereArgs: [id]
    );
  }

  Future<int> deleteBook(String id) async {
  Database db =await instance.getDatabase;
  return await db.delete(_tableName,
  where: 'id = ?',
  whereArgs: [id]
  );

}

}