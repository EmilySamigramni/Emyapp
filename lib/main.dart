import 'package:flutter/material.dart';
import 'myprofile.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity, 
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink
        ).copyWith(background: Colors.pink[50]),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Light pink background
      appBar: AppBar(
        title: const Text('Emily'),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Heart icons forming a circle around the center
          ..._buildHeartCircle(context),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Emily',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.pink[800], // Darker pink for text
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pink, // Button text color
                  ),
                  onPressed: () {
                    _showPasswordDialog(context);
                  },
                  child: const Text('Open'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeartCircle(BuildContext context) {
    const double radius = 150; // Radius of the circle
    const int numberOfHearts = 12; // Number of hearts in the circle

    final List<Widget> hearts = [];
    final double angleStep = 2 * pi / numberOfHearts; // Angle between hearts

    for (int i = 0; i < numberOfHearts; i++) {
      final double angle = i * angleStep;
      final double x = radius * cos(angle) + MediaQuery.of(context).size.width / 2;
      final double y = radius * sin(angle) + MediaQuery.of(context).size.height / 2;

      hearts.add(
        Positioned(
          top: y - 30, // Adjust heart position
          left: x - 30, // Adjust heart position
          child: Icon(
            Icons.favorite,
            color: Colors.pink[300 + (i % 4) * 100], // Different colors
            size: 60,
          ),
        ),
      );
    }

    return hearts;
  }

  void _showPasswordDialog(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Password'),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (passwordController.text == '250304') {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfilePage()),
                  );
                } else {
                  // Handle incorrect password
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Incorrect Password'),
                        content: const Text('Please try again.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
