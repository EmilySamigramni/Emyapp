import 'package:flutter/material.dart';
import 'mycalendar.dart'; // Ensure these files exist and contain the correct classes
import 'mylists.dart';
import 'puzzle.dart';
import 'forever.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.pink, // Ensure the AppBar background is pink
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
      body: Container(
        color: Colors.pink[50], // Light pink background for the body
        child: const Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink, // Title color
                  ),
                ),
                SizedBox(height: 20),
                _ProfileDetail(title: 'Name:', detail: 'Emily Samigramni', color: Colors.pink),
                _ProfileDetail(title: 'Birthday:', detail: '25 March 2004'),
                _ProfileDetail(title: 'ID Number:', detail: '0403250105083'),
                _ProfileDetail(title: 'Favourite Colour:', detail: 'Red'),
                _ProfileDetail(title: 'Favourite Number:', detail: '5'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.pink, // Pink background for drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.pink, // Pink background for header
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24, // Font size for menu title
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[50], // Lighter pink for header text
                ),
              ),
            ),
            ListTile(
              title: Text('My Profile', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('My Calendar', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyCalendarPage()),
                );
              },
            ),
            ListTile(
              title: Text('My Lists', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyListsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Puzzle', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PuzzlePage()),
                );
              },
            ),
            ListTile(
              title: Text('Forever And Always', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForeverPage()),
                );
              },
            ),
            ListTile(
              title: Text('App Settings', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                // Navigate to App Settings page
              },
            ),
            ListTile(
              title: Text('Back To Home', style: TextStyle(color: Colors.pink[50])),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.popUntil(context, ModalRoute.withName('/')); // Navigate back to home
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDetail extends StatelessWidget {
  final String title;
  final String detail;
  final Color? color;

  const _ProfileDetail({
    required this.title,
    required this.detail,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            detail,
            style: TextStyle(
              fontSize: 18,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
