
import 'package:flutter1/screen/update_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/screen/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {'/update-data': (context) => const UpdateBook()},
        home: const Home());
  }
}
