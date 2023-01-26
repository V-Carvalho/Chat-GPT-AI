import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:chatgptai/src/screens/Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Wakelock.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF202123),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF202123)),
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

