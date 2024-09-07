import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({super.key});

  @override
  _MyCalendarPageState createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Map to store notes for each date
  Map<String, String> _notesForDays = {};

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  // Function to load notes from shared preferences
  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString('notesForDays');
    if (notesString != null) {
      setState(() {
        _notesForDays = Map<String, String>.from(jsonDecode(notesString));
      });
    }
  }

  // Function to save notes to shared preferences
  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('notesForDays', jsonEncode(_notesForDays));
  }

  // Function to add a note for a specific date
  void _addNoteForDay(String note) {
    setState(() {
      _notesForDays[_selectedDay.toString()] = note;
    });
    _saveNotes();
  }

  // Function to show a dialog to enter a note
  Future<void> _showAddNoteDialog(BuildContext context) async {
    final TextEditingController noteController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(hintText: "Enter your note"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addNoteForDay(noteController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emstheapp Calendar'),  // Updated the app bar title
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, focusedDay) {
                final hasNote = _notesForDays.containsKey(date.toString());
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: hasNote ? Colors.blue : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: hasNote ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Display note for selected day if it exists
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _notesForDays[_selectedDay.toString()] ?? "No notes for this day",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.pink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () => _showAddNoteDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
