import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SCREEN/homescreen.dart';

void main() {
  runApp(const DailyJournalApp());
}

class DailyJournalApp extends StatefulWidget {
  const DailyJournalApp({super.key});

  @override
  State<DailyJournalApp> createState() => _DailyJournalAppState();
}

class _DailyJournalAppState extends State<DailyJournalApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Journal',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: HomeScreen(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
    );
  }
}
