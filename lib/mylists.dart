import 'package:flutter/material.dart';

class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  _MyListsPageState createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  List<Map<String, dynamic>> _headings = [];
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();

  void _addHeading() {
    final headingText = _headingController.text.trim();
    if (headingText.isNotEmpty) {
      setState(() {
        _headings.add({'heading': headingText, 'items': <String>[]});
        _headingController.clear();
      });
    }
  }

  void _addItems(int headingIndex) {
    final itemText = _itemController.text.trim();
    if (itemText.isNotEmpty) {
      setState(() {
        _headings[headingIndex]['items'].add(itemText);
        _itemController.clear();
      });
    }
  }

  void _editHeading(int index) {
    final heading = _headings[index];
    final TextEditingController editHeadingController = TextEditingController(text: heading['heading']);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Heading'),
          content: TextFormField(
            controller: editHeadingController,
            decoration: const InputDecoration(labelText: 'Heading'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _headings[index]['heading'] = editHeadingController.text.trim();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _editItem(int headingIndex, int itemIndex) {
    final item = _headings[headingIndex]['items'][itemIndex];
    final TextEditingController editItemController = TextEditingController(text: item);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: TextFormField(
            controller: editItemController,
            decoration: const InputDecoration(labelText: 'Item'),
            autofocus: true,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _headings[headingIndex]['items'][itemIndex] = editItemController.text.trim();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int headingIndex, int itemIndex) {
    setState(() {
      _headings[headingIndex]['items'].removeAt(itemIndex);
      if (_headings[headingIndex]['items'].isEmpty) {
        _headings.removeAt(headingIndex);
      }
    });
  }

  void _deleteHeading(int index) {
    setState(() {
      _headings.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
        backgroundColor: Colors.pink[300],
      ),
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _headingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Heading',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addHeading,
                ),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _headings.length,
                itemBuilder: (context, headingIndex) {
                  final heading = _headings[headingIndex];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.all(16.0),
                      title: Text(
                        heading['heading'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _editHeading(headingIndex);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteHeading(headingIndex);
                            },
                          ),
                        ],
                      ),
                      children: [
                        ...List.generate(
                          (heading['items'] as List<String>).length,
                          (itemIndex) {
                            final item = (heading['items'] as List<String>)[itemIndex];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              title: Text(item),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _editItem(headingIndex, itemIndex);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteItem(headingIndex, itemIndex);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _itemController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.favorite, color: Colors.pink),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () => _addItems(headingIndex),
                                    ),
                                  ),
                                  autofocus: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
