import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planner/models/task.dart';
import 'package:planner/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('usertasks');
  await Hive.openBox<String>('appTheme');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<String>('appTheme').listenable(),
        builder: (context, value, child) {
          final b = Hive.box<String>('appTheme');
          final themeChoice = b.get('themeChoice');
          return MaterialApp(
            themeMode: themeChoice == 'dark'
                ? ThemeMode.dark
                : themeChoice == 'light'
                    ? ThemeMode.light
                    : ThemeMode.system,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15.0))),
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent),
                    color: Colors.blue)),
            darkTheme: ThemeData(colorScheme: const ColorScheme.dark()),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        });
  }
}
