import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planner/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              color: Colors.blue)),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
