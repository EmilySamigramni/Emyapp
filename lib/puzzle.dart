import 'package:flutter/material.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make it responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate block size based on screen dimensions
    final blockWidth = screenWidth * 0.4;
    final blockHeight = screenHeight * 0.2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            spacing: 10.0, // Space between blocks
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children: <Widget>[
              _buildBlock('Adding Events', blockWidth, blockHeight),
              _buildBlock('Research and Info', blockWidth, blockHeight),
              _buildBlock('Religion', blockWidth, blockHeight),
              _buildBlock('Day Diary', blockWidth, blockHeight),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build a block with title and dynamic size
  Widget _buildBlock(String title, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.pink,
          width: 2.0,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}