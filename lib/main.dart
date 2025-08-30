import 'package:book_tracker/pages/favorites_screen.dart';
import 'package:book_tracker/pages/home_screen.dart';
import 'package:book_tracker/pages/saved_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  final List<Widget> _screens=[
   const HomeScreen(),
   const SavedScreen(),
   const FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar:
       BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: theme.colorScheme.onPrimary,
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        backgroundColor: theme.colorScheme.inversePrimary,
        onTap: (value) {
          setState(() {
            _currentIndex =value;
          });
        },
        items:[
         BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
         BottomNavigationBarItem(icon: Icon(Icons.save),label:'Saved'),
         BottomNavigationBarItem(icon: Icon(Icons.favorite),label:'Favorites'),
      ]
      ),
    );

  }
}