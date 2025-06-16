import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  final String date;
  final String? existingText;

  EntryScreen({required this.date, this.existingText});

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingText ?? '');
  }

  void _saveEntry() {
    String text = _controller.text.trim();
    Navigator.pop(context, text); // just return a string
  }

  void _deleteEntry() {
    Navigator.pop(context, null); // null = delete
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry: ${widget.date}'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteEntry,
            tooltip: 'Delete',
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveEntry,
            tooltip: 'Save',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Write  your journal entry here...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
