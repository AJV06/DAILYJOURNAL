import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  final String date;
  final String? existingText;

  const EntryScreen({super.key, required this.date, this.existingText});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingText ?? '');
  }

  void _saveEntry() {
    Navigator.pop(context, _controller.text.trim());
  }

  void _deleteEntry() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📝 ${widget.date}'),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _deleteEntry),
          IconButton(icon: const Icon(Icons.save), onPressed: _saveEntry),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Write your journal entry here...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
