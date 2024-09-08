import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({super.key});

  @override
  _MyCalendarPageState createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  final Map<DateTime, List<String>> _events = {};
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  final TextEditingController _eventController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month; // Default to full month view

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  void _addEvent() {
    final eventText = _eventController.text;
    if (eventText.isNotEmpty) {
      setState(() {
        if (_events[_selectedDay] != null) {
          _events[_selectedDay]!.add(eventText);
        } else {
          _events[_selectedDay] = [eventText];
        }
        _eventController.clear();
      });
    }
  }

  void _editEvent(int index, String updatedText) {
    setState(() {
      _events[_selectedDay]![index] = updatedText;
    });
  }

  void _deleteEvent(int index) {
    setState(() {
      _events[_selectedDay]!.removeAt(index);
      if (_events[_selectedDay]!.isEmpty) {
        _events.remove(_selectedDay);
      }
    });
  }

  void _showEditDialog(int index) {
    final TextEditingController editController = TextEditingController(
      text: _events[_selectedDay]![index],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Event'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(labelText: 'Event'),
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
                _editEvent(index, editController.text);
                Navigator.pop(context);
              },
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
        title: const Text('My Calendar'),
        backgroundColor: Colors.pink[200], // Pretty pink AppBar
      ),
      backgroundColor: Colors.pink[50], // Light pink background
      body: Column(
        children: [
          // Toggle Button to switch between 2-week and full-month view
          ToggleButtons(
            isSelected: [_calendarFormat == CalendarFormat.week, _calendarFormat == CalendarFormat.month],
            onPressed: (index) {
              setState(() {
                _calendarFormat = index == 0 ? CalendarFormat.week : CalendarFormat.month;
              });
            },
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('2 Weeks'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Month'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue, // Blue circle for today's date
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.pink, // Pink circle for the selected day
                shape: BoxShape.circle,
              ),
              defaultTextStyle: const TextStyle(
                color: Colors.black, // Black text for days
              ),
              outsideDaysVisible: true, // Show days outside the current month
              // Ensure markers are not applied
              markersMaxCount: 0,
            ),
            calendarBuilders: CalendarBuilders(
              // Use calendarBuilders for custom day cell widgets
              defaultBuilder: (context, day, focusedDay) {
                final isEventDay = _events[day] != null && _events[day]!.isNotEmpty;

                return Container(
                  margin: const EdgeInsets.all(4.0), // Space around the square
                  decoration: BoxDecoration(
                    color: isEventDay ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                    border: isEventDay ? Border.all(color: Colors.blue, width: 2.0) : null,
                    borderRadius: BorderRadius.circular(4.0), // Square corners
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isEventDay ? Colors.blue : Colors.black, // Change text color based on event presence
                    ),
                  ),
                );
              },
            ),
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _eventController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Event',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addEvent,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _events[_selectedDay] != null
                  ? _events[_selectedDay]!.asMap().entries.map((entry) {
                      int index = entry.key;
                      String event = entry.value;
                      return ListTile(
                        title: Text(event),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deleteEvent(index);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  : [],
            ),
          ),
        ],
      ),
    );
  }
}
