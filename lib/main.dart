import 'package:flutter/material.dart';
import 'myprofile.dart'; // Import the MyProfilePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emstheapp',  // Updated the title
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[100],
          titleTextStyle: TextStyle(
            color: Colors.pink[900],
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.pink[900],
            backgroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Emily'),  // Updated the home page title
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.pink[900],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to MyProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfilePage()),
                );
              },
              child: const Text('Open'),
            ),
          ],
        ),
      ),
    );
  }
}
