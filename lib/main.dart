import 'package:flutter/material.dart';
import 'package:my_contact/add_contact_widget.dart';
import 'package:my_contact/contact_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ContactWidget());
  }
}
