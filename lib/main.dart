import 'package:flutter/material.dart';
import 'calendar_tab.dart';
import 'package:firebase_core/firebase_core.dart';
import 'model/event.dart';
import 'Data.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}


class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalendarTab()
    );
  }
}


