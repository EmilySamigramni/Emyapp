import 'package:flutter/material.dart';

class ForeverPage extends StatefulWidget {
  const ForeverPage({super.key});

  @override
  _ForeverPageState createState() => _ForeverPageState();
}

class _ForeverPageState extends State<ForeverPage> {
  // Map to store images under headings
  final Map<String, List<String>> _memories = {};

  // Function to add an image under a specific heading
  void _addMemory(String heading, String imagePath) {
    setState(() {
      if (_memories.containsKey(heading)) {
        _memories[heading]!.add(imagePath);
      } else {
        _memories[heading] = [imagePath];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forever Memories'),
      ),
      body: ListView(
        children: _memories.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Display images under this heading
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: entry.value.map((imagePath) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset(
                          imagePath,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement your image picker and add functionality here
          // For demonstration, we'll just add a dummy image
          _addMemory('Family', 'assets/your_image.png'); // Replace with actual image path
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Image',
      ),
    );
  }
}
