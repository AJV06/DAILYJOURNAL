import 'package:flutter/material.dart';
import 'entryscreen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, String> _journalEntries = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _openEntryScreen(String date) async {
    final result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EntryScreen(date: date, existingText: _journalEntries[date]),
      ),
    );

    setState(() {
      if (result == null || result.isEmpty) {
        _journalEntries.remove(date);
      } else {
        _journalEntries[date] = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedDateStr = DateFormat(
      'yyyy-MM-dd',
    ).format(_selectedDay ?? _focusedDay);
    final entryText = _journalEntries[selectedDateStr];

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Daily Journal'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2040, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.indigo,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: entryText == null
                ? Center(child: Text('No entry for $selectedDateStr'))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        title: Text(selectedDateStr),
                        subtitle: Text(
                          entryText.split('\n').first,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => _openEntryScreen(selectedDateStr),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEntryScreen(selectedDateStr),
        child: const Icon(Icons.add),
        tooltip: 'Add/Edit Entry',
      ),
    );
  }
}
