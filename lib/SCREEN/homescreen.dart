import 'package:flutter/material.dart';
import 'entryscreen.dart';
import 'package:intl/intl.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homescreen> {
  final Map<String, String> journalEntries = {};

  void _openEntryScreen(String date) async {
    final result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EntryScreen(date: date, existingText: journalEntries[date]),
      ),
    );

    setState(() {
      if (result == null || result.isEmpty) {
        journalEntries.remove(date); // Delete if result is null or empty
      } else {
        journalEntries[date] = result; // Save or update entry
      }
    });
  }

  String _getTodayDate() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final dates = journalEntries.keys.toList()..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(title: Text('Daily Journal')),
      body: dates.isEmpty
          ? Center(child: Text('Click + to add entries.'))
          : ListView.builder(
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                return ListTile(
                  title: Text(date),
                  subtitle: Text(
                    journalEntries[date]!.split('\n').first,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => _openEntryScreen(date),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEntryScreen(_getTodayDate()),
        child: Icon(Icons.add),
        tooltip: 'Add Entry',
      ),
    );
  }
}
