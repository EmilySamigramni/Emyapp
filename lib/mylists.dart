import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For encoding/decoding JSON data


class MyListsPage extends StatefulWidget {
  const MyListsPage({super.key});

  @override
  _MyListsPageState createState() => _MyListsPageState();
}

class _MyListsPageState extends State<MyListsPage> {
  List<Map<String, dynamic>> _lists = []; // Store heading and its items
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLists(); // Load stored lists when the page is initialized
  }

  Future<void> _loadLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedLists = prefs.getString('myLists');
    if (storedLists != null) {
      setState(() {
        _lists = List<Map<String, dynamic>>.from(json.decode(storedLists));
      });
    }
  }

  Future<void> _saveLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myLists', json.encode(_lists));
  }

  void _addNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New List'),
          content: TextField(
            controller: _headingController,
            decoration: const InputDecoration(hintText: 'Enter list heading'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  _lists.add({
                    'heading': _headingController.text,
                    'items': []
                  }); // Add new list with empty items
                });
                _headingController.clear();
                _saveLists(); // Save the new list
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editList(int index) {
    _headingController.text = _lists[index]['heading'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit List'),
          content: TextField(
            controller: _headingController,
            decoration: const InputDecoration(hintText: 'Edit list heading'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _lists[index]['heading'] = _headingController.text;
                });
                _headingController.clear();
                _saveLists(); // Save changes
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteList(int index) {
    setState(() {
      _lists.removeAt(index);
    });
    _saveLists(); // Save changes
  }

  void _addNewItem(int listIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: TextField(
            controller: _itemController,
            decoration: const InputDecoration(hintText: 'Enter item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  _lists[listIndex]['items'].add(_itemController.text);
                });
                _itemController.clear();
                _saveLists(); // Save changes
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editItem(int listIndex, int itemIndex) {
    _itemController.text = _lists[listIndex]['items'][itemIndex];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: TextField(
            controller: _itemController,
            decoration: const InputDecoration(hintText: 'Edit item'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _lists[listIndex]['items'][itemIndex] = _itemController.text;
                });
                _itemController.clear();
                _saveLists(); // Save changes
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int listIndex, int itemIndex) {
    setState(() {
      _lists[listIndex]['items'].removeAt(itemIndex);
    });
    _saveLists(); // Save changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
      ),
      body: ListView.builder(
        itemCount: _lists.length,
        itemBuilder: (context, listIndex) {
          return ExpansionTile(
            title: Text(
              _lists[listIndex]['heading'],
              style: const TextStyle(
                fontWeight: FontWeight.bold, // Makes the heading bold
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editList(listIndex),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteList(listIndex),
                ),
              ],
            ),
            children: <Widget>[
              for (int i = 0; i < _lists[listIndex]['items'].length; i++)
                ListTile(
                  title: Text(_lists[listIndex]['items'][i]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editItem(listIndex, i),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteItem(listIndex, i),
                      ),
                    ],
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _addNewItem(listIndex),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewList,
        child: const Icon(Icons.add),
      ),
    );
  }
}
