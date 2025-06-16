import 'package:flutter/material.dart';
import 'SCREEN/homescreen.dart'; // correct path to homescreen.dart

void main() {
  runApp(DailyJournalApp());
}

class DailyJournalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Journal ',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Homescreen(),
    );
  }
}
