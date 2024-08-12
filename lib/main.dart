import 'package:flutter/material.dart';
import 'package:my_contact/contact_provider.dart';
import 'package:my_contact/contact_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => ContactProvider())],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ContactWidget());
  }
}
